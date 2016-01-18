(in-package :cl-user)
(defpackage which-test
  (:use :cl :fiveam)
  (:export :run-tests))
(in-package :which-test)

(def-suite tests
  :description "which tests.")
(in-suite tests)

(test simple-test
  (let ((bash #p"/bin/bash"))
    (when (probe-file bash)
      (is
       (equal (which:which "bash") bash)))))

(defun run-tests ()
  (run! 'tests))
