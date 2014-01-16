#lang racket

(provide SCAD cube cylinder union difference scale rotate translate range
         debug)

(require racket/format)
(require racket/string)

(define SCAD 
  (lambda (outf . args)
    (call-with-output-file outf #:exists 'truncate
      (lambda (out)
        (map (lambda (x) (display x out)) args)))))

(define (arg? arg)
  (match arg
    [(list (? symbol?) _) #t]
    [`#(,x ,y ,z) #t]
    [_ #f]))

(define (format-arg arg)
  (match arg
    [`(,name ,val)
     (string-append (symbol->string name) "=" (format-arg val))]
    [`#(,x ,y ,z)
     (string-append "[" (~a x) "," (~a y) "," (~a z) "]")]
    [a (~a a)]))

(define (format-args args)
  (match args
    [`(,(? symbol? name) ,val)
     (string-append (symbol->string name) "=" (~a val))]
    [`#(,x ,y ,z)
     (string-append "[" (~a x) "," (~a y) "," (~a z) "]")]
    [(? list? args)
     (string-join (map format-arg args) ",")]))
     
    
; Define a primitive -- name();
(define-syntax-rule (defprim name)
  (define name
    (lambda args
      (string-append (symbol->string (quote name)) "(" (format-args args) ");"))))

(defprim cube)
(defprim cylinder)

; Define a modifier -- name(){ .. }
(define-syntax-rule (defmodifier name)
  (define name
    (lambda argstuff
      (match argstuff
        ; base case -- listof args and a listof strings
        [(list (list (? arg? args) (... ...)) (list (? string? stuff) (... ...)))
         (string-append (symbol->string (quote name))
                        "(" 
                        (format-args args) 
                        ") {"
                        (string-append* stuff)
                        "}")]
        ; just a pile of strings
        [(list (? string? stuff) (... ...)) 
         (apply name `(() ,stuff))]
        ; args and then a pile of strings
        [(list args (? string? stuff) (... ...))
         (apply name `(,args ,stuff))]
        ; single arg and then a listof strings
        [(list (? arg? arg) (list (? string? stuff) (... ...)))
         (apply name `((,arg) ,stuff))]
        ))))

(defmodifier union)
(defmodifier difference)
(defmodifier scale)
(defmodifier rotate)
(defmodifier translate)

(define/match (range lo hi)
  [(a a) '()]
  [(lo _)
   (cons lo (range (+ lo 1) hi))])

(define (debug x)
  (string-append "#" x))