(in-package :cl-user)
(defpackage which
  (:use :cl)
  (:export :which)
  (:documentation "A clone of the UNIX which command."))
(in-package :which)

(defun which (program-name)
  "Return the absolute pathname to the executable name (a string), if any,
otherwise return NIL."
  (let ((path (uiop:parse-native-namestring program-name)))
    (unless (and (uiop:relative-pathname-p path)
                 (uiop:file-pathname-p path))
      (error "The program name is not a relative file pathname: ~A" program-name))
    (loop for directory in (path-parse:path) do
      (loop for file in (cl-fad:list-directory directory) do
        (when (and (equal (pathname-name path) (pathname-name file))
                   (equal (pathname-type path) (pathname-type file)))
          (return-from which file)))))
  nil)
