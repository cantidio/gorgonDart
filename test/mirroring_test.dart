library mirroring_test;

import "package:unittest/unittest.dart";
import '../src/gorgon.dart';

void main()
{
  test
  (
      "Mirroring.None members value check", (){
        Mirroring mirror = Mirroring.None;

        expect( mirror.value, equals( 0 ) );
        expect( mirror.name, equals( "None" ) );
  });
  test
  (
      "Mirroring.H members value check", (){
        Mirroring mirror = Mirroring.H;

        expect( mirror.value, equals( 1 ) );
        expect( mirror.name, equals( "H" ) );
  });
  test
  (
      "Mirroring.V members value check", (){
        Mirroring mirror = Mirroring.V;

        expect( mirror.value, equals( 2 ) );
        expect( mirror.name, equals( "V" ) );
  });
  test
  (
      "Mirroring.HV members value check", (){
        expect( Mirroring.HV.value, equals( 3 ) );
        expect( Mirroring.HV.name, equals( "HV" ) );
  });
  test
  (
      "Mirroring.VH members value check", (){
        expect( Mirroring.VH.value, equals( 3 ) );
        expect( Mirroring.VH.name, equals( "HV" ) );
  });
  
  test
  (
      "Mirroring.HV == Mirroring.VH members value check", (){
        expect( Mirroring.HV.value, equals( Mirroring.VH.value ) );
        expect( Mirroring.HV.name, equals( Mirroring.VH.name ) );
  });
  
  test
  (
      "Mirroring Operator ==", (){
        expect( Mirroring.H, equals( Mirroring.H ) );
        expect( Mirroring.V, equals( Mirroring.V ) );
        expect( Mirroring.HV, equals( Mirroring.HV ) );
        expect( Mirroring.VH, equals( Mirroring.VH ) );
  });
  
  test
  (
      "Mirroring Operator |", (){

        expect( Mirroring.None  | Mirroring.None , equals( Mirroring.None ) );
        expect( Mirroring.H     | Mirroring.H    , equals( Mirroring.H    ) );
        expect( Mirroring.V     | Mirroring.V    , equals( Mirroring.V    ) );
        expect( Mirroring.HV    | Mirroring.HV   , equals( Mirroring.HV   ) );
        expect( Mirroring.VH    | Mirroring.VH   , equals( Mirroring.VH   ) );
        
        expect( Mirroring.None  | Mirroring.H    , equals( Mirroring.H    ) );
        expect( Mirroring.None  | Mirroring.V    , equals( Mirroring.V    ) );
        expect( Mirroring.None  | Mirroring.HV   , equals( Mirroring.HV   ) );
        expect( Mirroring.None  | Mirroring.VH   , equals( Mirroring.VH   ) );
        
        expect( Mirroring.H     | Mirroring.None , equals( Mirroring.H    ) );
        expect( Mirroring.V     | Mirroring.None , equals( Mirroring.V    ) );        
        expect( Mirroring.HV    | Mirroring.None , equals( Mirroring.HV   ) );
        expect( Mirroring.VH    | Mirroring.None , equals( Mirroring.VH   ) );
        
        expect( Mirroring.H     | Mirroring.V    , equals( Mirroring.HV   ) );
        expect( Mirroring.H     | Mirroring.HV   , equals( Mirroring.HV   ) );
        expect( Mirroring.H     | Mirroring.VH   , equals( Mirroring.VH   ) );
        
        expect( Mirroring.V     | Mirroring.H    , equals( Mirroring.HV   ) );
        expect( Mirroring.V     | Mirroring.HV   , equals( Mirroring.HV   ) );
        expect( Mirroring.V     | Mirroring.VH   , equals( Mirroring.VH   ) );
        
        expect( Mirroring.HV     | Mirroring.H   , equals( Mirroring.HV   ) );
        expect( Mirroring.HV     | Mirroring.V   , equals( Mirroring.HV   ) );
        expect( Mirroring.VH     | Mirroring.H   , equals( Mirroring.VH   ) );
        expect( Mirroring.VH     | Mirroring.V   , equals( Mirroring.VH   ) );
  });
  
  test
  (
      "Mirroring Operator &", (){

        expect( Mirroring.None  & Mirroring.None , equals( Mirroring.None ) );
        expect( Mirroring.H     & Mirroring.H    , equals( Mirroring.H    ) );
        expect( Mirroring.V     & Mirroring.V    , equals( Mirroring.V    ) );
        expect( Mirroring.HV    & Mirroring.HV   , equals( Mirroring.HV   ) );
        expect( Mirroring.VH    & Mirroring.VH   , equals( Mirroring.VH   ) );
        
        expect( Mirroring.None  & Mirroring.H    , equals( Mirroring.None ) );
        expect( Mirroring.None  & Mirroring.V    , equals( Mirroring.None ) );
        expect( Mirroring.None  & Mirroring.HV   , equals( Mirroring.None ) );
        expect( Mirroring.None  & Mirroring.VH   , equals( Mirroring.None ) );
        
        expect( Mirroring.H     & Mirroring.None , equals( Mirroring.None ) );
        expect( Mirroring.V     & Mirroring.None , equals( Mirroring.None ) );        
        expect( Mirroring.HV    & Mirroring.None , equals( Mirroring.None ) );
        expect( Mirroring.VH    & Mirroring.None , equals( Mirroring.None ) );
        
        expect( Mirroring.H     & Mirroring.V    , equals( Mirroring.None ) );
        expect( Mirroring.H     & Mirroring.HV   , equals( Mirroring.H    ) );
        expect( Mirroring.H     & Mirroring.VH   , equals( Mirroring.H    ) );
        
        expect( Mirroring.V     & Mirroring.H    , equals( Mirroring.None ) );
        expect( Mirroring.V     & Mirroring.HV   , equals( Mirroring.V    ) );
        expect( Mirroring.V     & Mirroring.VH   , equals( Mirroring.V    ) );
        
        expect( Mirroring.HV     & Mirroring.H   , equals( Mirroring.H    ) );
        expect( Mirroring.HV     & Mirroring.V   , equals( Mirroring.V    ) );
        expect( Mirroring.VH     & Mirroring.H   , equals( Mirroring.H    ) );
        expect( Mirroring.VH     & Mirroring.V   , equals( Mirroring.V    ) );
  });
}