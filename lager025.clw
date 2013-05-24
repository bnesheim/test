

   MEMBER('lager.clw')                                ! This is a MEMBER module

                     MAP
                       INCLUDE('LAGER025.INC'),ONCE        !Local module procedure declarations
                     END


Function_Save_UsedLineHistory PROCEDURE               ! Declare Procedure
LOC:Pointers         LONG,DIM(20)
  CODE
! Lagrer data om forbruk hentet med UsedLineHistory kommandoen fra Proxy.
! Template: <id>: <dline_id> <used> <date>; <notes>
! Eksempel:  1: 1 3 2010-07-23 14:44:09.640000;Test

   FREE(QUsed)

   I# = 1

   LOOP
      GET(QDataLines, I#)
      IF ERRORCODE() THEN
         BREAK
      ELSE

         LOC:Pointers[1] = 1                                ! Start av linje

         J#=1
         K#=2

         L#   = LEN(CLIP(QDL:LineDataStr))

         LOOP L# TIMES
            IF QDL:LineDataStr[J#] = '<32>' THEN            !Finner mellomrom som deler felt
               LOC:Pointers[K#] = J#
               K# += 1
            END

            J# += 1
         END

         P1# = LOC:Pointers[1]                              ! Linjestart - Start ID usedline
         P2# = LOC:Pointers[2]                              ! Start related ID delivered
         P3# = LOC:Pointers[3]                              ! Start used
         P4# = LOC:Pointers[4]                              ! Start dato_tid_str
         P5# = INSTRING(';',CLIP(QDL:LineDataStr),1,1)      ! Start av notes for levering

         QUS:id       = QDL:LineDataStr[P1#:P2#-1]          ! id fra proxy for usedline post
         QUS:dline_id = QDL:LineDataStr[P2#+1:P3#-1]        ! Delivered id som forbtuk gjelder
         QUS:used     = QDL:LineDataStr[P3#+1:P4#-1]        ! Verdi som angir antall sekker brukt
         QUS:date_str = QDL:LineDataStr[P4#+1:P5#-1]        ! Streng som angir dato og tid
         QUS:notes    = LEFT(QDL:LineDataStr[P5#+1:L#])     ! Merknad knyttet til forbruk

         QUS:dato     = DEFORMAT(QUS:date_str[1:10],@D010)  ! DEFORMATET dato fra date_str
         QUS:tid      = DEFORMAT(QUS:date_str[12:20],@T4)   ! DEFORMATET tid fra date_str

         ADD(QUsed)
      END

      I# += 1
   END

   STREAM(Used)

   IF ERRORCODE() THEN
      MESSAGE(ERROR())
   ELSE

      J# = 1

      LOOP RECORDS(QUsed) TIMES
         GET(QUsed,J#)

         IF ERRORCODE() THEN
            MESSAGE(ERROR())
            BREAK
         ELSE
            USE:id = QUS:id
            
            IF Access:Used.Fetch(USE:K_id) NOT= Level:Benign THEN

               USE:id            = QUS:id
               USE:dline_id      = QUS:dline_id
               USE:used          = QUS:used
               USE:Dato          = QUS:dato
               USE:Tid           = QUS:tid
               USE:date_time_str = QUS:date_str
               USE:notes         = QUS:notes

               IF Access:Used.Insert() NOT= Level:Benign THEN
                  MESSAGE('Feil ved lagring av UseLineHistory til lokalt register.')
               END
            END
         END

         J# += 1
      END
   END

   FLUSH(Used)
   IF ERRORCODE() THEN MESSAGE(ERROR()) END





