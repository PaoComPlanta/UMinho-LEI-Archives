module Exemplo2_Spec where 
import Test.HUnit
import Exemplo2

tests = TestList [
      "Teste a (1,3)" ~: 0.33 ~=? mydiv 1 3,
      "Teste b (5,0)" ~: 0 ~=? mydiv 5 0,
      "Teste c (5,0)" ~: 0 ~=? mydiv1 5 0,
      "Teste d (15,3)" ~: 5 ~=? mydiv 15 3
      ]