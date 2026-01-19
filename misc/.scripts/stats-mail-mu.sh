#!/bin/sh
exec guile -s $0 $@
!#

(use-modules (mu) (mu message) (mu stats) (mu plot))
(mu:initialize)

;; create a list like (("Mon" . 13) ("Tue" . 23) ...)
(define weekday-table
  (mu:weekday-numbers->names
    (sort
      (mu:tabulate-messages
        (lambda (msg)
          (tm:wday (localtime (mu:date msg)))))
      (lambda (a b) (< (car a) (car b))))))

(for-each
  (lambda (elm)
    (format #t "~a: ~a\n" (car elm) (cdr elm)))
  weekday-table)
