#lang racket

(require "scad.rkt")

(define slide-cylinder 
  (rotate #(90 0 0)
  (translate #(-0.3 0 0)
  (difference
   (cylinder '(h 1) '(r 1) '($fn 26))
   (translate #(0 0 -0.05) (scale #(1.1 1.1 1.1) (cube)))
   (translate #(0.3 0 -0.05) (scale #(-2.1 2.1 1.1) (translate #(0 -0.5 0) (cube))))
   ))))
  

(SCAD "mmplat.scad"
      (union
      
       (difference
        (union
         
         ; the platform
         (difference
          (cylinder '(h 2.85) '(r 40) '($fn 60))
          (translate #(0 0 -1)
                     (difference
                      (cylinder '(h 3) '(r 39.3) '($fn 60))
                      (translate #(0 1 0) (scale #(100 50 10)
                                                 (translate #(-0.5 -1 -0.5)
                                                            (cube)))))
                     ))
         
         ; 2 motor posts
         
         (translate #(-17.5 8.5 0)
                    (cylinder '(h 2.85) '(r 5.5) '($fn 60)))
         (translate #(17.5 8.5 0)
                    (cylinder '(h 2.85) '(r 5.5) '($fn 60)))
         
         )
        
        ; thru hole for motor posts
        (translate #(-17.5 8.5 0)
                   (union
                    (translate #(0 0 -1) (cylinder '(h 5) '(r 2.085) '($fn 60)))
                    (translate #(0 0 1) (cylinder '(h 2) '(r1 2.085) '(r2 4.085))))
                   )
        (translate #(17.5 8.5 0)
                   (union
                    (translate #(0 0 -1) (cylinder '(h 5) '(r 2.085) '($fn 60)))
                    (translate #(0 0 1) (cylinder '(h 2) '(r1 2.085) '(r2 4.085))))
                   )
        
        
        
        ; the cube to cut off half the circle
        (translate #(0 0 0) (scale #(100 50 10)
                                   (translate #(-0.5 -1 -0.5)
                                              (cube))))
        
        ; the center hole for the motor
        (cylinder '(h 5) '(r 10) '($fn 60))
        
        
        )
       
      
      ; the slide
      
      (translate #(-25 0.5 2.85)
                 (difference
                  (scale #(15 17 20) slide-cylinder)
                  (translate #(-1 -1 1) (scale #(15 15 20) slide-cylinder))
                  )
                 )
      
      ))