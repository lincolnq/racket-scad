#lang racket


(require "scad.rkt")


(define (rot4 f)
  (scale #(1 1 1)
         (map (lambda (a) 
                (rotate `((a ,(* a (/ 360 4))) (v #(0 0 1))) 
                        (f)))
              (range 0 4))))

(SCAD "mmwheel.scad"
      (union
       (difference
        ; fixme: set h to 7 when you get it right
        (cylinder '(h 7) '(r 40) '($fn 60))
        
        (translate #(0 0 1) (cylinder '(h 7) '(r 39) '($fn 60)))
       
        (translate #(0 0 -1)
                   (difference
                    (cylinder '(h 10) '(r 3) '($fn 60))
                    (translate #(2.25 -5 -1) (scale #(10 10 12) (cube)))
                    (translate #(-2.25 -5 -1) (scale #(-10 10 12) (cube)))
                    ))
                  
                  
       
        (rot4 (lambda () (translate #(23 0 -1) (cylinder '(h 10) '(r 8) '($fn 30)))))
        
               
       
        )
       
       (rot4 (lambda () (translate #(23 0 0) 
                                   (difference
                                    (cylinder '(h 7) '(r 8.7) '($fn 30))
                                    (translate #(0 0 -1)
                                               (cylinder '(h 10) '(r 8) '($fn 30)))
                                    ))))
                 
       (translate #(0 0 0)
       (difference
        ; the 'walls' of the center post
        (difference
         (cylinder '(h 7) '(r 3.7) '($fn 60))
         (translate #(3 -5 -1) (scale #(10 10 12) (cube)))
         (translate #(-3 -5 -1) (scale #(-10 10 12) (cube)))
         )
        
        ; the 'hole' of the center post
        (translate #(0 0 -1)
                   
                   (difference
                    (cylinder '(h 11) '(r 3) '($fn 60))
                    (translate #(2.25 -5 -1) (scale #(10 10 12) (cube)))
                    (translate #(-2.25 -5 -1) (scale #(-10 10 12) (cube)))
                    )
                   ))
              ))
       )