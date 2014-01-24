#lang racket

(require "scad.rkt")

(SCAD "mmplat.scad"
      (difference
      (union
       (difference
        (cylinder '(h 2.85) '(r 40) '($fn 60))
        (translate #(0 0 -0.7)
                   (cylinder '(h 3) '(r 39.3) '($fn 60))))
       
       ; 2 motor posts
       
       (translate #(-16.5 7.5 0)
                  (cylinder '(h 2.85) '(r 5.5) '($fn 60)))
       (translate #(16.5 7.5 0)
                  (cylinder '(h 2.85) '(r 5.5) '($fn 60)))
       
       )
      
      ; thru hole for motor posts
      (translate #(-16.5 7.5 0)
                 (union
                  (translate #(0 0 -1) (cylinder '(h 5) '(r 2.085) '($fn 60)))
                  (translate #(0 0 0.1) (cylinder '(h 2.85) '(r1 2.085) '(r2 5))))
                 )
      (translate #(16.5 7.5 0)
                 (union
                  (translate #(0 0 -1) (cylinder '(h 5) '(r 2.085) '($fn 60)))
                  (translate #(0 0 0.1) (cylinder '(h 2.85) '(r1 2.085) '(r2 5))))
                 )
                 
      
      

      (translate #(0 0 0) (scale #(100 50 10)
                                 (translate #(-0.5 -1 -0.5)
                                            (cube))))
      
      (cylinder '(h 5) '(r 10) '($fn 60))
      
      
      )
      )