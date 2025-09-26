# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command
from ranger.core.loader import CommandLoader
from pathlib import Path

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

# You can import any python module as needed.
import os

# Any class that is a subclass of "Command" will be integrated into ranger as a
# command.  Try typing ":my_edit<ENTER>" in ranger!


class my_edit(Command):
    # The so-called doc-string of the class will be visible in the built-in
    # help that is accessible by typing "?c" inside ranger.
    """:my_edit <filename>

    A sample command for demonstration purposes that opens a file in an editor.
    """

    # The execute method is called when you run this command in ranger.
    def execute(self):
        # self.arg(1) is the first (space-separated) argument to the function.
        # This way you can write ":my_edit somefilename<ENTER>".
        if self.arg(1):
            # self.rest(1) contains self.arg(1) and everything that follows
            target_filename = self.rest(1)
        else:
            # self.fm is a ranger.core.filemanager.FileManager object and gives
            # you access to internals of ranger.
            # self.fm.thisfile is a ranger.container.file.File object and is a
            # reference to the currently selected file.
            target_filename = self.fm.thisfile.path

        # This is a generic function to print text in ranger.
        self.fm.notify("Let's edit the file " + target_filename + "!")

        # Using bad=True in fm.notify allows you to print error messages:
        if not os.path.exists(target_filename):
            self.fm.notify("The given file does not exist!", bad=True)
            return

        # This executes a function from ranger.core.acitons, a module with a
        # variety of subroutines that can help you construct commands.
        # Check out the source, or run "pydoc ranger.core.actions" for a list.
        self.fm.edit_file(target_filename)

    # The tab method is called when you press tab, and should return a list of
    # suggestions that the user will tab through.
    # tabnum is 1 for <TAB> and -1 for <S-TAB> by default
    def tab(self, tabnum):
        # This is a generic tab-completion function that iterates through the
        # content of the current directory.
        return self._tab_directory_content()

class lastdirmutt(Command):
    """:lastdir
    Jump to the last saved directory or the parent of the last saved file.
    """
    def execute(self):
        pathfile = os.path.expanduser("/tmp/ranger-mutt-lastwd")

        if not os.path.exists(pathfile):
            self.fm.notify("No lastdir file found!", bad=True)
            return

        with open(pathfile) as f:
            path = f.read().strip()

        if not path:
            self.fm.notify("lastdir file is empty!", bad=True)
            return

        if os.path.isdir(path):
            # Path is a directory → jump directly
            self.fm.cd(path)
        elif os.path.isfile(path):
            # Path is a file → jump to containing folder
            self.fm.cd(os.path.dirname(path))
        else:
            self.fm.notify("Saved path is invalid!", bad=True)

class lastdir(Command):
    """:lastdir
    Jump to the last saved directory, or the one in mutt.
    """
    def execute(self):
        # pathfile = os.path.expanduser("/tmp/ranger-lastwd")
        # if os.path.exists(pathfile):
        path1 = Path("/tmp/ranger-lastwd")
        path2 = Path("/tmp/ranger-mutt-lastwd")
        # pathfile = next((p for p in (path1, path2) if p.exists()), None)

        pathfile = None
        chosen_source = None  # will hold "path1" or "path2"

        for label, p in (("regular", path1), ("mutt", path2)):
            if p.exists():
                pathfile = p
                chosen_source = label
                break
        # self.fm.notify(chosen_source, bad=True)
        # self.fm.notify(pathfile, bad=True)

        if pathfile:
            with open(pathfile) as f:
                path = f.read().strip()
            self.fm.open_console(f"Going to {chosen_source} folder")
            if os.path.isdir(path):
                self.fm.cd(path)
            elif os.path.isfile(path):
                self.fm.cd(os.path.dirname(path))
            else:
                self.fm.notify("Saved path is not a directory!", bad=True)
        else:
            self.fm.notify("No lastdir file found!", bad=True)



class mkcd(Command):
    """
    :mkcd <dirname>

    Creates a directory with the name <dirname> and enters it.
    """

    def execute(self):
        from os.path import join, expanduser, lexists
        from os import makedirs
        import re

        dirname = join(self.fm.thisdir.path, expanduser(self.rest(1)))
        if not lexists(dirname):
            makedirs(dirname)

            match = re.search('^/|^~[^/]*/', dirname)
            if match:
                self.fm.cd(match.group(0))
                dirname = dirname[match.end(0):]

            for m in re.finditer('[^/]+', dirname):
                s = m.group(0)
                if s == '..' or (s.startswith('.') and not self.fm.settings['show_hidden']):
                    self.fm.cd(s)
                else:
                    ## We force ranger to load content before calling `scout`.
                    self.fm.thisdir.load_content(schedule=False)
                    self.fm.execute_console('scout -ae ^{}$'.format(s))
        else:
            self.fm.notify("file/directory exists!", bad=True)

class compress(Command):
    def execute(self):
        """ Compress marked files to current directory """
        cwd = self.fm.thisdir
        marked_files = cwd.get_selection()

        if not marked_files:
            return

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        original_path = cwd.path
        parts = self.line.split()
        au_flags = parts[1:]

        descr = "compressing files in: " + os.path.basename(parts[1])
        obj = CommandLoader(args=['apack'] + au_flags + \
                [os.path.relpath(f.path, cwd.path) for f in marked_files], descr=descr, read=True)

        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)

    def tab(self, tabnum):
        """ Complete with current folder name """

        extension = ['.zip', '.tar.gz', '.rar', '.7z']
        return ['compress ' + os.path.basename(self.fm.thisdir.path) + ext for ext in extension]

class mdnotes(Command):
    """
    :mdnotes

    Create an empty .md file for each selected file in the current directory,
    using the same base name.
    """

    def execute(self):
        for fobj in self.fm.thistab.get_selection():
            # base, _ = os.path.splitext(fobj.relative_path)
            # md_file = f"{base}.md"
            # full_path = os.path.join(self.fm.thisdir.path, md_file)
            # open(full_path, 'a').close()
            base_name = os.path.splitext(os.path.basename(fobj.relative_path))[0]
            md_filename = f"{base_name}.md"
            full_path = os.path.join(self.fm.thisdir.path, md_filename)

            if not os.path.exists(full_path):
                with open(full_path, 'w') as f:
                    f.write(f"# {base_name}\n")

        self.fm.ui.browser.marked_items.clear()  # Clear marked items from UI
        self.fm.notify("Created .md files for selected items.")
