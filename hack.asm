!MASK_BUTTON_X      = $0040
!MASK_BUTTON_A      = $0080
!MASK_BUTTON_SELECT = $2000
!MASK_BUTTON_Y      = $4000
!MASK_BUTTON_B      = $8000

sa1rom
; change controls
org $3ebac
        ; was #$4000
        ; Y => B for inhaling, etc.
        lda     #!MASK_BUTTON_B
org $3ebb2
        ; was #$8000
        ; B => A/Y for jumping, etc.
        lda     #(!MASK_BUTTON_A|!MASK_BUTTON_Y)
org $3ebb8
        ; was #$0080
        ; A => X for helper, etc.
        lda     #!MASK_BUTTON_X


org $029ad4
        jml     ditch_copy_ability

; ditch copy ability by pressing Select
org $02fa81
ditch_copy_ability:
        pha
        and     #!MASK_BUTTON_SELECT
        bne     .pressedSelect
        pla
        and     $36b2, y
        clc
        bne     .pressedHelperButton
        jml     $029ada
.pressedHelperButton
        jml     $029af2
.pressedSelect
        pla
        jml     $029b18
