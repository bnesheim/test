

   MEMBER('lager.clw')                                ! This is a MEMBER module

                     MAP
                       INCLUDE('LAGER010.INC'),ONCE        !Local module procedure declarations
                     END


Function_Save_BarcodeRead PROCEDURE  (PAR:File)       ! Declare Procedure
LOC:LinePnt          LONG,DIM(40000)
LOC:Pointers         LONG,DIM(20)
LOC:File             STRING(320000)
  CODE
! Lagrer data mottatt fra proxy for BarcodeRead kommandoen
! Kommando returnerer variabelt format basert på hvor koden er brukt
! derfor lagres bare bare 2 elementer barcode + typeinfo i tillegg brukes
! INSTRING for 'Tank' og 'DLine'. Type settes det det som blir funnet eller NONE.
! Format: stores_tank table     : <barcode>: <type>; Tank  <tankNo> ; <info>  
!         stores_deliveredlines : <barcode>: <type>; DLine <id>, <dId> ; <info>
!         neither table         : <barcode>: <type>; Noen; <info>"             

   LOC:File = PAR:File

   FREE(QDataLines)
   FREE(QBarcode)

   L# = LEN(CLIP(LOC:File))

   I# = 1

   LOC:LinePnt[1] = -1    ! Start av data
   T# = 2

   LOOP L# TIMES
      IF LOC:File[I#] = '<13>' THEN

         LOC:LinePnt[T#] = I#

         QDL:LineDataStr = LOC:File[(LOC:LinePnt[T#-1]+2):(LOC:LinePnt[T#]-1)]

         ADD(QDataLines)

         T# += 1
      END

      I# += 1
   END

   I# = 1

   LOOP
      GET(QDataLines, I#)
      IF ERRORCODE() THEN
         BREAK
      ELSE
         LOC:Pointers[1] = 1        ! Start av linje

         J#=1
         K#=2

         L#   = LEN(CLIP(QDL:LineDataStr))

         LOOP L# TIMES
            IF QDL:LineDataStr[J#] = ' ' THEN
               LOC:Pointers[K#] = J#
               K# += 1
            END
            J# += 1
         END

         P1# = LOC:Pointers[1]      ! Start av linje
         P2# = LOC:Pointers[2]      ! Slutt på barcode

         QBA:ID_Barcode = I#
         QBA:barcode    = QDL:LineDataStr[P1#:P2#-2]
         QBA:Typeinfo   = QDL:LineDataStr[P2#+1:L#]

         IF INSTRING('Tank', QDL:LineDataStr) THEN
            QBA:type = 'Tank'
         ELSE
            IF INSTRING('DLine', QDL:LineDataStr) THEN
               QBA:type = 'DLine'
            ELSE
!               QBA:type = 'None'
               IN# = INSTRING(';',QBA:Typeinfo,1,1)
               QBA:type = QBA:Typeinfo[1:IN#-1]
            END
         END

         ADD(QBarcode)

      END

      I# += 1
   END

   STREAM(Barcode)
   IF ERRORCODE() THEN
      MESSAGE(ERROR())
   ELSE

      J# = 1

      LOOP (I#-1) TIMES
         GET(QBarcode,J#)
         IF ERRORCODE() THEN
            MESSAGE(ERROR())
            BREAK
         ELSE
            BAR:barcode = QBA:barcode

            IF Access:Barcode.Fetch(BAR:K_barcode) NOT= Level:Benign THEN

!               BAR:ID_Barcode  = QBA:ID_Barcode
               BAR:barcode     = QBA:barcode
               BAR:type        = QBA:type
               BAR:typeinfo    = QBA:typeinfo

               IF Access:Barcode.Insert() NOT= Level:Benign THEN
                  MESSAGE('Feil ved lokal lagring: ' & ERROR())
                  BREAK
               END
            ELSE

               BAR:barcode     = QBA:barcode
               BAR:type        = QBA:type
               BAR:typeinfo    = QBA:typeinfo

               IF Access:Barcode.Update() NOT= Level:Benign THEN
                  MESSAGE('Feil ved lokal oppdatering: ' & ERROR())
                  BREAK
               END
            END
         END

         J# += 1
      END

      FLUSH(Barcode)
      IF ERRORCODE() THEN MESSAGE(ERROR()) END
    
   END




