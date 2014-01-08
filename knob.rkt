#lang racket

(require "scad.rkt")

; knob is created with a radius of 1.0 at widest,
; translated so the bottom is at origin
(define knob
  (scale #(1/2.5 1/2.5 1/2.5)
         (translate #(0 0 1.5)
         (union
          ; the knob "grip"
          (translate #(0 0 -0.6) (scale #(1.45 1.45 2)
                 (map (lambda (a) 
                        (rotate `((a ,(* a (/ 360 20))) (v #(0 0 1))) (cube)))
                      (range 0 20))))
          ; the knob "widening" section (cone)
          (translate #(0 0 -1)
                     (cylinder '(h 1.15) '(r2 1.3) '(r1 2.5) '($fn 30)))
          
          ; the knob "base"
          (translate #(0 0 -1.5)
                     (cylinder '(h 0.5) '(r 2.5) '($fn 30)))
          
         ))))

(SCAD "test.scad"
      (difference
       (translate #(0 0 0)
                  (scale #(8 8 8) knob))
       
       ; cut a hole with r=1.775mm and 4.4mm deep
       (translate #(0 0 -0.1)
                  (difference
                   (cylinder '(h 4.5) '(r 1.975) '($fn 60))
                   (translate #(-0.4 0.925 -0.1) (scale #(0.8 10 4.7) (cube)))
                   ;(translate #(-0.245 -0.625 -0.1) (scale #(0.49 -10 4.7) (cube)))
                   )
                  )
       ))

