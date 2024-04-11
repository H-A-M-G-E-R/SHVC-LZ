; SHVC-LZ
; David Lindecrantz <optiroc@me.com>
;
; LZ4 example usage

.p816
.smart -
.feature c_comments

.autoimport
.export Main

Main:
    .a8
    .i16

    ; Set source/destination
    ;
    ; LZ4_DecompressBlock requires the following parameters:
    ;   x           Source offset
    ;   y           Destination offset
    ;   b:a         Destination:Source banks
    ldx #Compressed_Length
    stx LZ4_Length_w
    ldy #.loword(Destination)
    ldx #.loword(Compressed)
    lda #^Destination
    xba
    lda #^Compressed

    jsl LZ4_DecompressBlock

:   wai
    bra :-

.segment "RODATA"
Compressed:
    .incbin "../../test_data/abam.txt.lz4"
Compressed_END:
Compressed_Length = Compressed_END - Compressed

.segment "BSS7F"
Destination:
    .res $ffff
