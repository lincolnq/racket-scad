#lang racket

(require "scad.rkt")

(SCAD "test.scad"
 (union
  (scale #(1 1 1.5)
         (map (lambda (a) 
                (rotate `((a ,(* a 12)) (v #(0 0 1))) (cube)))
              (range 0 30)))
  (translate #(0 0 -1)
             (cylinder '(h 1.15) '(r2 1.3) '(r1 2.5) '($fn 30)))
  
  (translate #(0 0 -1.5)
             (cylinder '(h 0.5) '(r 2.5) '($fn 30)))))

