'''Read and write vCal and iCal files--partially implementation.

    Usage example:

        >>>import vcal
        >>>calendar = vcal.parse("test.ics")
        >>>print len(calendar.events)
        3
        >>>print calendar.events[0].summary
        'Test'

Parse can handle a stream, file name, url, string, or stdin.

Current abilities:
    - parses events and turns thems into objects, properties become attributes
    - uses regular expressions, so code is compact and should be extensible
    - handles folding, although not well (see below)
    - parses durations and creates a durations_seconds property which turns
      the duration string into a number of seconds.

Current limitations:
    - only parses VEVENTS
    - ignores all property parameters; for example, the CN parameter is
      ignored:
            ATTENDEE;CN="Troy Brown":tbrown@nfl.patriots.com
    - drops linefeeds in folded paragraphs
    - uses ical unfolding rules on vcal folded data
    - does not handle folded vcal properties (requires use of properties)
    - reads whole ics or vcal file into memory before parsing.
    - when exporting, there is no validation that an event's or calendar's
      properties are valid iCal or vCal properties.
    - does not parse any calendar attributes

I tried to keep this parser simple.  It doesn't to any hard work like trying
to represent ics recurrence (or vcal recurrence) in some Pythonic way.  It
creates an Event object, and for each ics (or vcal) property it parses,
creates an new attribute and save the value there.  It does have a small bit
of intelligence--it knows which properties are plurals so it can add the next
value to the list instead of overwriting the current value.

Most simple vCal and iCal files should be interchangeable.  "Simple" means no
recurrence rules, no timezone objects (ical-specific), and no folding.

FOLDING
---------

Folding is when you have property values that are longer than 75 characters.
With vcal, you can only fold at a whitespace character whereas with ical you
can fold where-ever you want.

The current folding logic needs improvement, as it does not preserve line feed
characters.  This is due to an early decision to make the parser
end-of-line-friendly; that is, allow CRLF, CR, or just LF all be considered
line terminators.  (The idea was trying to make the parser forgiving--a bunch
of the client implementations out there are not so great--granted, I don't
really know if this is one class of problem they typically have.)  However,
this lenience makes it impossible to unfold properly, and results in the
routine eating any linefeeds in your nice long, multi-line description.  The
nicely broken up text becomes one huge run-on paragraph.  Either the parser
should set a state variable that defines the what line endings are, or stick
strictly to the carriage-return/line-feed requirement in the spec.

Copyright (C) 2003 Mark Bucciarelli

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

'''

__version__ = '$Id: vcal.py,v 1.2 2003/12/29 03:18:33 uid67313 Exp $'


import calendar
import re
import time
import types


SECONDS_PER_MINUTE =  60
SECONDS_PER_HOUR   =  60 * SECONDS_PER_MINUTE
SECONDS_PER_DAY    =  24 * SECONDS_PER_HOUR
SECONDS_PER_WEEK   =   7 * SECONDS_PER_DAY
SECONDS_PER_YEAR   = 364 * SECONDS_PER_DAY

#-----------------------------------------------------------------------
#
# REGULAR EXPRESSIONS FOR PARSING
#
#-----------------------------------------------------------------------

# Taken from Formal Definition section of the vcal spec.  In the Backus-Naur
# Notation, they also listed a number of ASCII characters that I didn't
# recognize.  For example:
#       carriage return     ASCII CR        15
#       linefeed            ASCII LF        12
#       space               ASCII SP        40
#       horizontal-tab      ASCII HT        11
#
# Does this mean chr(15) for an ASCII CR??  I didn't include these numbers in
# the definitions below, because I didn't understand them.

CR = chr(13)  # \r
LF = chr(10)  # \n

# This regular expression class is more lenient that the spec.  To follow the
# spec exactly, we would only match \r\n, not \n\r or just \n or \r.
CRLF = '[%s%s]' % (CR, LF)
ONE_OR_MORE_CRLF = '[%s%s][%s%s]*' % (CR, LF, CR, LF)

# Whitespace--one or more spaces or tabs
WS = ' \t'
ZERO_OR_MORE_WS = '[' + WS + ']*'
ONE_OR_MORE_WS = '[%s][%s]*' % (WS, WS)

# Whitespace with line separators.  
WSLS = ' \t\r\n'
ZERO_OR_MORE_WSLS = '[' + WSLS + ']*'
ONE_OR_MORE_WSLS = '[%s][%s]*' % (WSLS, WSLS)

VCAL_START = re.compile(\
        ZERO_OR_MORE_WSLS \
        + 'BEGIN' + ZERO_OR_MORE_WS + ':' \
        + ZERO_OR_MORE_WS + 'VCALENDAR' \
        + ZERO_OR_MORE_WSLS + ONE_OR_MORE_CRLF)

VCAL_END = re.compile(\
        'END' + ZERO_OR_MORE_WS + ':' + ZERO_OR_MORE_WS \
        + 'VCALENDAR' + ZERO_OR_MORE_WS + ONE_OR_MORE_CRLF)

VEVENT_START = re.compile(\
        'BEGIN' + ZERO_OR_MORE_WS + ':' + ZERO_OR_MORE_WS + 'VTODO' \
        + ZERO_OR_MORE_WS + ONE_OR_MORE_CRLF)

VEVENT_END = re.compile(\
        'END' + ZERO_OR_MORE_WS + ':' + ZERO_OR_MORE_WS + 'VTODO' \
        + ZERO_OR_MORE_WS + ONE_OR_MORE_CRLF)
#VEVENT_START = re.compile(\
#        'BEGIN' + ZERO_OR_MORE_WS + ':' + ZERO_OR_MORE_WS + 'VEVENT' \
#        + ZERO_OR_MORE_WS + ONE_OR_MORE_CRLF)
#
#VEVENT_END = re.compile(\
#        'END' + ZERO_OR_MORE_WS + ':' + ZERO_OR_MORE_WS + 'VEVENT' \
#        + ZERO_OR_MORE_WS + ONE_OR_MORE_CRLF)

# More lenient than the spec--allows spaces before the property name and a
# CRLF after property name.  (This is how libical outputs properties.) This
# (the CRLF after the property name) is one way ical differs from vcal.
EVENT_PROPERTY = re.compile(\
        '^([A-Z][^;:%s]+)' % WSLS \
        + ZERO_OR_MORE_WSLS \
        + '[^:]*' \
        + ZERO_OR_MORE_WSLS \
        + ':' + '([^%s%s]+)' % (CR, LF) \
        + ONE_OR_MORE_CRLF)                

# Continuation lines in property values start with one or more whitespace
# characters.
FOLDED = re.compile('^%s(.*)%s' % (ONE_OR_MORE_WS, ONE_OR_MORE_CRLF))

DURATION = re.compile(\
'P([0-9]*Y)*([0-9]*M)*([0-9]*W)*([0-9]*D)*T*([0-9]*H)*([0-9]*M)*([0-9]*S)*')


class ParseError(Exception):
    def __init__(self, charcnt, msg):
        self.msg = msg
        self.charcnt = charcnt
    def __str__(self):
        s = 'vCal Parse Error: ' + self.msg
        if self.charcnt is not None:
            s += ' (at character %s)' % self.charcnt
        return s


class Event:
    '''Stores a calendar event.'''

    # These object attributes are lists.  Taken from ical RFC2445, Sec. 4.6.1
    pluralprops = ('categories', 'resources', 'attendee', 'comment', 'attach',
                'contact', 'exdate', 'exrule', 'rstatus', 'related', 'rdate',
                'rrule')

    def __init__(self, **kw):
        self.loadprops(kw)

    def __cmp__(self, other):
        '''Two Events are equal if they have exactly the same attributes and
        their values are all the same.
        
        Sort order = dtstart, summary (if those attributes exist in both
        Events).  If they do not exist, then it's pretty arbitrary.  The checks
        are done in this order:
            - the event with more attributes comes first
            - the attribute names are compared (in alphabetical order).  If
              the names are different, the first mismatch is compared based on
              the alphabet; for example, "a" < "b" and "A" < "b".
            - the attribute values are compared (in alphabetical order)
        '''

        # First, handle sort order
        if hasattr(self, 'dtstart') and hasattr(other, 'dtstart'):
            if self.dtstart != other.dtstart:
                return cmp(self.dtstart, other.dtstart)

        if hasattr(self, 'summary') and hasattr(other, 'summary'):
            if self.summary.lower() != other.summary.lower():
                return cmp(self.summary, other.summary)

        # Two sort keys are equal, compare attribute count.  We don't want to
        # compare methods (because instance methods _will_ be different) or
        # built in fields; for example '__doc__'.
        f = lambda x, y: not y.startswith('__') \
                and type(getattr(x, y)) != types.MethodType
        self_attrs = self.event_attributes()
        other_attrs = other.event_attributes()
        if len(self_attrs) > len(other_attrs):
            return 1
        elif len(self_attrs) < len(other_attrs):
            return -1

        # Same attribute count, compare attribute names.
        self_attrs.sort()
        other_attrs.sort()
        for i in range(len(self_attrs)):
            if self_attrs[i] != other_attrs[i]:
                return cmp(self_attrs[i], other_attrs[i])

        # Same attribute names, compare attribute values
        for i in range(len(self_attrs)):
            l = getattr(self, self_attrs[i])
            r = getattr(other, other_attrs[i])
            if l != r:
                return cmp(l, r)

        # If we made it here, they are equal.
        return 0
    
    def event_attributes(self):
        '''Return a list of attributes associated with this event.

        Convenience method that filters out built-ins (like __doc__) and
        method names.'''

        f = lambda x, y: not y.startswith('__') \
                and type(getattr(x, y)) != types.MethodType \
                and y != "pluralprops"
        return [a for a in dir(self) if f(self, a)]


    def as_vcal(self):
        '''Return the vcal string representing this object.'''
#        l = ["BEGIN:VTODO"]
        l = ["BEGIN:VTODO"]
        for attribute in self.event_attributes():
            val = getattr(self, attribute)

            # Special handling, as Python already uses the "class" attribute.
            if attribute == "klass":
                attributes = "class"

            # If a long line, fold long at whitespace (vcal requirement)
            if len(val) > 75:
                rest = val
                l1 = []
                while len(rest) > 75:
                    pos = rest.rfind(' ', 0, 75)
                    l1.append(rest[:pos])
                    rest = rest[pos:].strip()
                l1.append(rest)
                val = (CR + LF + ' ').join(l1)

            l.append(":".join( (attribute.upper(), val)))
        l.append("END:VTODO")
#        l.append("END:VEVENT")
        return (CR + LF).join(l)

    def __hash__(self):
        '''Hash key must be the same for objects that are equal.'''

        f = lambda x, y: not y.startswith('__') \
                and type(getattr(x, y)) != types.MethodType
        self_attrs = [a for a in dir(self) if f(self, a)]
        s = ''
        for a in self_attrs:
            s += str(getattr(self, a))
        return hash(s)

    def loadprops(self, kw):
        '''Load object attributes from dictionary.  attr = key.lower()

        Non-string keys are ignored.'''

        for key, value in kw.items():
            self.loadprop(key, value)

    def loadprop(self, name, value):
        '''Using __setattr__ would be more elegant (and safer) ...'''

        if type(name) != type(''):
            return
        name = name.lower()

        # Python will not allow to have an object property named "class"
        # FIXME: this should _definately_ go in __setattr__!!
        # This is extremely fragile--for example, the user will go
        #           event.class="PRIVATE"
        # and it will not work as expected.
        if name == 'class':
            name = 'klass'

        if not hasattr(self, name):
            if name in self.pluralprops:
                setattr(self, name, (value,) )
            else:
                setattr(self, name, value)
        else:
            # This property already exists for this event.  Here we are
            # more lenient than the iCal spec, as we overwrite the old value.
            # To strictly follow the spec, this would be an invalid ical file
            # and we should raise an exception.
            #
            # The iCal spec requires that the following properties only appear
            # once:
            #
            #   class / created / description / dtstart / geo /
            #   last-mod / location / organizer / priority /
            #   dtstamp / seq / status / summary / transp /
            #   uid / url / recurid /
            #
            # I'm not sure if vCal has the same restriction.
            if name in self.pluralprops:
                setattr(self, name, getattr(self, name) + (value,) )
            else:
                setattr(self, name, value)

    def postprocessing(self):
        '''Computes useful metadata for the event.

        - computes duration_seconds.
        - ensures object has both a DTSTART and a DTEND

        Always call this after all properties are loaded into event.

        Cases Handled:

            (1) Event has DTSTART and a DURATION
                    - DTEND set to DTSTART + DURATION (my addition)
            (2) Event has DTSTART and DTEND
            (3) Event has DTEND only 
                    - event duration = 0
                    - DTSTART set equal to DTEND (my addition)
                    - ref: vCalendar vs. 1, Sec. 2.3.11: 
            (4) Event has DTSTART only
                    - event duration = 0
                    - DTSTART set equal to DTEND (my addition)
                    - ref: vCalendar vs. 1, Sec. 2.3.11: 
        '''

        self.duration_seconds = 0
        if hasattr(self, 'dtstart') and self.dtstart:

            if hasattr(self, 'duration'):
                self.duration_seconds = \
                        duration2seconds(self.dtstart, self.duration)

                start = parsetime(self.dtstart)
                t = calendar.timegm(start[:-1] + (0, 0, 0))
                t += self.duration_seconds
                end = time.gmtime(t)
                self.dtend = time.strftime("%Y%m%dT%H%M%S", end)
                self.dtend += self.dtstart[-1]

            elif hasattr(self, 'dtend'):
                start = parsetime(self.dtstart)
                end = parsetime(self.dtend)
                t1 = time.mktime(start[:-1] + (0, 0, 0))
                t2 = time.mktime(end[:-1] + (0, 0, 0))
                self.duration_seconds = int(t2 - t1)
            else:
                self.dtend = self.dtstart

        elif hasattr(self, 'dtend'):
            self.dtstart = self.dtend

        else:
            # No dtstart or dtend.  This is actually a valid iCalendar event,
            # so we can't raise a ParseError.
            pass


class Calendar:
    def __init__(self):
        self.events = ()
        self.version = '1.0'

    def as_vcal(self):
        l = ["BEGIN:VCALENDAR", "VERSION:%s" % self.version]
        for e in self.events:
            l.append(e.as_vcal())
        l.append("END:VCALENDAR")
        return (CR + LF).join(l)

def parsetime(s):
    '''Parse vcal datetime string into it's parts.
    
    Returns tuple: year, month, day, hour, minute, seconds, and timezone.
    
    Right now, timezone is either "utc" or "float" as iCalendar time zone
    objects are not supported.'''

    timezone = "float"
    if len(s) in (len('20031130T091815'), len('20031130T091815Z')):
        try:
            year = int(s[:4])
            month = int(s[4:6])
            day = int(s[6:8])
            hour = int(s[9:11])
            min = int(s[11:13])
            sec = int(s[13:15])
            if len(s) == len('20031130T091815Z') and s[15].upper() == 'Z':
                timezone = 'utc'
        except ValueError:
            raise ParseError(0, 'vcal.parsetime: invalid string: "%s"' % s)
    elif len(s) == len('20031130'):
        try:
            year = int(s[:4])
            month = int(s[4:6])
            day = int(s[6:8])
            hour = min = sec = 0
        except ValueError:
            raise ParseError(0, 'vcal.parsetime: invalid string: "%s"' % s)
    else:
        raise ParseError(0, 
                'vcal.parsetime: datetime string is wrong length: "%s"' % s)
    
    return year, month, day, hour, min, sec, timezone
    
def parseproperty(data):
    '''Parse vcal property and it's value.  Ignore parameters.
    
    Return property, value, start_position, end_position tuple.'''


    # Some RegExp basics:
    #
    #       >>>s = 'mark123'
    #       >>>import re
    #       >>>p = re.compile('mark')
    #       >>>m = p.search(s)
    #       >>>m.start(), m.end()
    #       (0, 4)
    #       >>>s[0:4]
    #       'mark'
    #       >>>s[4:]
    #       '123'

    prop = val = ''
    start = end = 0

    # The EVENT_PROPERTY regexp will match to the end of the first line.
    m = EVENT_PROPERTY.search(data)

    # Deal with folding before applying regular expression.  A long
    # description is folded if the next line starts with a white space; for
    # example:
    #   DESCRIPTION: A fol
    #    ded des
    #    cription!
    #
    # We unfold this to be:
    #
    #   DESCRIPTION: A folded description!
    #
    # before applying the event property regexp that parses out the property
    # name and the property value.
    if m and len(m.groups()) == 2:

        unfolded = data[m.start():m.end()]
        start = m.start()

        # The ending character index returned must related to the original
        # string, not the unfolded one so we keep track of the original index
        # using the local variable end.
        end = m.end()

        m = FOLDED.match(data[end:])
        while m and len(m.groups()) == 1:

            # Remove the trailing CRLF.
            unfolded = unfolded.replace(CR+LF, '') 

            # There was something funky going on with appending strings and
            # the unfolded string already had a \r\n in it--the appended
            # string was overwriting the begining of the previous string, and
            # the unit tests were failing.
            #
            # I think a carriage return moves the "cursor" back to first
            # column of the current line.  Removing the carriage returns
            # avoids this problem.
            unfolded = unfolded.replace(CR, '') 

            # This code does not require a CRLF to terminate a line (as both
            # the vcal and ical specs require).  And here is the first place
            # this decision bites us--there is no way to maintain a linefeed
            # in a long description.  If we leave the '\n' in the description,
            # parsing it with the event property regexp below will stop at the
            # first line feed.
            #
            # FIXME: Require CRLF to terminate a line.
            unfolded = unfolded.replace(LF, '') 

            #print 'unfolded: "%s"' % unfolded
            #print 'folded  : "%s"' % m.group(1)

            unfolded = unfolded + m.group(1)

            end += m.end()
            m = FOLDED.match(data[end:])


        # Need a CRLF at end to get a match on EVENT_PROPERTY
        unfolded += CR+LF

        #print 'unfolded: "%s"' % unfolded
        m = EVENT_PROPERTY.match(unfolded)
        prop = m.group(1).strip()
        val = m.group(2).strip()
        #print 'prop    : "%s"' % prop
        #print 'value   : "%s"' % val

    #if prop and val:
    #    print 'vcal.parseproperty: %s=%s' % (prop, val)
    return prop, val, start, end

def duration2seconds(dtstart, d):
    '''Return number of seconds vcal duration works out to be.

    Need dtstart in case duration includes a number of months.'''

    m = DURATION.match(d)
    if not m:
        raise ParseError(0, 'vcal.duration2seconds: invalid duration "%s"' % d)

    # Build dictionary of duration components; e.g., {'H':1, 'M':30}
    components = {}
    keys = ' YMWDHmS'
    for i in range(len(m.groups())+1):
        if i == 0: continue
        if m.group(i): components[keys[i]] = int(m.group(i)[:-1])

    seconds = 0
    for k, v in components.items():
        if k == 'Y': seconds += v * SECONDS_PER_YEAR
        elif k == 'M':

            # If the start date is Feb 10, and the interval is:
            #       one month  --> 28
            #       two months --> 28 + 31
            # Ok, so this is easy.
            y = int(dtstart[:4])
            m = int(dtstart[4:6])
            d = int(dtstart[6:8])
            while v:
                first_day, day_cnt = calendar.monthrange(y, m)
                seconds += day_cnt * SECONDS_PER_DAY
                v -= 1
                m += 1
                if m > 12: 
                    m = 1
                    y += 1
        elif k == 'W': seconds += v * SECONDS_PER_WEEK
        elif k == 'D': seconds += v * SECONDS_PER_DAY
        elif k == 'H': seconds += v * SECONDS_PER_HOUR
        elif k == 'm': seconds += v * SECONDS_PER_MINUTE
        elif k == 'S': seconds += v
        else:
            assert 0, 'Programming Error--unexpected condition (d=%s)' % d
        
    return seconds

def parse(vcalsource):
    '''Parse a vcalendar stream.

    vcalsource can be an url, a filename, a stream, a string, or stdin.

    Raises an assertion error if vcalsource is a tuple, a list or None'''

    assert type(vcalsource) not in (type(()), type([])), "Invalid vcalsource (%s)" % vcalsource
    assert vcalsource is not None

    # Adapted from Mark Pilgrim's "Dive Into Python" toolkit.py--open
    # anything.
    stream = None
    if stream is None and hasattr(vcalsource, "read"):
        stream = vcalsource

    if stream is None and vcalsource == '-':
        import sys
        stream = sys.stdin

    if stream is None:
        try: 
            stream = file(vcalsource)
        except (IOError, OSError): 
            pass

    if stream is None:
        try:
            import urllib
            stream = urllib.urlopen(vcalsource)
        except (IOError, OSError): 
            pass

    if stream is None:
        import StringIO
        stream = StringIO.StringIO(str(vcalsource))

    parsedchars = 0

    # Read stream into memory and then close stream.
    data = stream.read()
    stream.close()

    # Make sure this is a valid vcal file.
    m = VCAL_START.match(data)
    if not m:
        raise ParseError(0, 'No BEGIN:VCALENDAR--invalid vcal file')
    data = data[m.end():]
    parsedchars += m.end()

    # Parse events
    c = Calendar()
    eventstart = VEVENT_START.search(data)
    while eventstart:
        eventend = VEVENT_END.search(data)
        if eventstart and not eventend:
            raise ParseError(parsedchars, 'Missing END:VEVENT--invalid vcal file')
        eventend_idx = parsedchars + eventend.start()

        # Parse event properties
        e = Event()
        data = data[eventstart.end():]
        parsedchars += eventstart.end()
        prop, val, start, end = parseproperty(data)
        e.loadprop(prop, val)
        parsedchars += end
        while prop and parsedchars < eventend_idx:
            data = data[end:]
            prop, val, start, end = parseproperty(data)
            e.loadprop(prop, val)
            parsedchars += end

        e.postprocessing()

        c.events += (e,)

        # We've sliced off the data we have parsed, so we need to recompute
        # the ending character of the event end marker.
        eventend = VEVENT_END.search(data)
        data = data[eventend.end():]
        parsedchars += eventend.end()

        eventstart = VEVENT_START.search(data)

    return c
