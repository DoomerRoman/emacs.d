
(defun doomer/mark (movement-function)
  (if (not (use-region-p))
      (progn (push-mark (point) t t)
	     (funcall movement-function))
    (funcall movement-function)))


(use-package doomer/basic
  :bind
  (:map doomer/keymap
	("M-i" . previous-line)
	("M-I" . doomer/previous-line-mark)
	("M-k" . next-line)
	("M-K" . doomer/next-line-mark)

	("M-j" . backward-char)
	("M-J" . doomer/backward-char-mark)
	("M-l" . forward-char)
	("M-L" . doomer/forward-char-mark)

	("M-q" . beginning-of-line)
	("M-Q" . doomer/beginning-of-line-mark)
	("M-a" . end-of-line)
	("M-A" . doomer/end-of-line-mark)

	("M-," . beginning-of-buffer)
	("M-<" . doomer/beginning-of-buffer-mark)
	("M-." . end-of-buffer)
	("M->" . doomer/end-of-buffer-mark)

	)

  :init

  (defun doomer/previous-line-mark ()
    (interactive)
    (doomer/mark #'previous-line))

  (defun doomer/next-line-mark ()
    (interactive)
    (doomer/mark #'next-line))

  (defun doomer/backward-char-mark ()
    (interactive)
    (doomer/mark #'backward-char))

  (defun doomer/forward-char-mark ()
    (interactive)
    (doomer/mark #'forward-char))

  (defun doomer/beginning-of-line-mark ()
    (interactive)
    (doomer/mark #'beginning-of-line))

  (defun doomer/end-of-line-mark ()
    (interactive)
    (doomer/mark #'end-of-line))

  (defun doomer/beginning-of-buffer-mark ()
    (interactive)
    (doomer/mark #'beginning-of-buffer))

  (defun doomer/end-of-buffer-mark ()
    (interactive)
    (doomer/mark #'end-of-buffer))
  )


(use-package doomer/word
  :bind
  (:map doomer/keymap
	("M-u" . doomer/word-backward)
	("M-U" . doomer/word-backward-mark)
	("M-o" . doomer/word-forward)
	("M-O" . doomer/word-forward-mark)
	("M-DEL" . doomer/delete-word-backward)
	("M-<delete>" . doomer/delete-word-forward)
	)

  :init
  
  (defun doomer/word-comprehend-backward (char-function)
    "passed function processes words consisting only of alphabetic characters"
    (let ((case-fold-search nil))
      (cond ((looking-back "[^[:alpha:]]\\|[A-Z]\\|[А-Я]") (funcall char-function))
	    ((while (looking-back "[a-z]\\|[а-я]") (funcall char-function)))
	    ((looking-back "[A-Z]\\|[А-Я]") (funcall char-function)))))

  (defun doomer/word-comprehend-forward (char-function)
    "passed function processes words consisting only of alphabetic characters"
    (let ((case-fold-search nil))
      (cond ((looking-at "[^[:alpha:]]") (funcall char-function))
  	    ((looking-at "[A-Z]\\|[А-Я]\\|[a-z]\\|[а-я]") (funcall char-function)
  	     (while (looking-at "[a-z]\\|[а-я]") (funcall char-function))))))

  (defun doomer/word-backward ()
    (interactive)
    (doomer/word-comprehend-backward #'backward-char))

  (defun doomer/word-forward ()
    (interactive)
    (doomer/word-comprehend-forward #'forward-char))

  (defun doomer/delete-word-backward ()
    (interactive)
    (doomer/word-comprehend-backward (lambda () (delete-backward-char 1))))

  (defun doomer/delete-word-forward ()
    (interactive)
    (doomer/word-comprehend-forward (lambda () (delete-forward-char 1))))

  (defun doomer/word-backward-mark ()
    (interactive)
    (doomer/mark #'doomer/word-backward))

  (defun doomer/word-forward-mark ()
    (interactive)
    (doomer/mark #'doomer/word-forward))

  )
