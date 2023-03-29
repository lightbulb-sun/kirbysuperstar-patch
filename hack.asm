!MASK_BUTTON_X      = $0040
!MASK_BUTTON_A      = $0080
!MASK_BUTTON_SELECT = $2000
!MASK_BUTTON_Y      = $4000
!MASK_BUTTON_B      = $8000

!CODE_A             = $4d
!CODE_B             = $4e
!CODE_X             = $64
!CODE_Y             = $65


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


; fix controls for AI

; was #$8000
; B => A for jumping, etc.
org $06dc03
        lda     #!MASK_BUTTON_A
org $06dc88
        lda     #!MASK_BUTTON_A
org $06e09c
        lda     #!MASK_BUTTON_A

; was #$4000
; Y => B for inhaling, etc.
org $06e126
        lda     #!MASK_BUTTON_B
org $06e1c6
        lda     #!MASK_BUTTON_B
org $06e1e6
        lda     #!MASK_BUTTON_B

; was #$0080
; A => X for helper, etc.
org $06dd11
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


; fix instruction text
norom
org $b1966
        ; Jump by pushing B
        db      !CODE_A
org $b19e4
        ; Jump by pushing B
        db      !CODE_A
org $b1a75
        ; To make Kirby fly, press B repeatedly...
        db      !CODE_A
org $b1ad6
        ; Kirby flies higher and higher as you continue to push B
        db      !CODE_A
org $b1bc7
        ; To make Kirby fly, push B while he is in the air
        db      !CODE_A
org $b1c10
        ; Take the food by continually pressing B
        db      !CODE_A
org $b1d92
        ; By pushing Y, Kirby will inhale almost anything...
        db      !CODE_B
org $b1e4e
        ; Push Y to inhale
        db      !CODE_B
org $b1ed9
        ; Push Y to inhale an enemy
        db      !CODE_B
org $b1f0e
        ; Push Y to spit out a star
        db      !CODE_B
org $b1f77
        ; Push Y to spit out the enemy
        db      !CODE_B
org $b1f9d
        ; Pushing A or Down on the Control Pad swallows an inhaled object
        db      !CODE_X
org $b206d
        ; Push B, ...
        db      !CODE_A
org $b2075
        ; ... then Y quickly.
        db      !CODE_B
org $b2305
        ; When Kirby inhales an enemy, push A to swallow
        db      !CODE_X
org $b231e
        ; Press Y to inhale and...
        db      !CODE_B
org $b232e
        ; ...A to swallow.
        db      !CODE_X
org $b234d
        ; Again, push A to swallow an enemy that you've inhaled.
        db      !CODE_X
org $b239b
        ; Stop goofing around. Push Y to inhale and...
        db      !CODE_B
org $b23ab
        ; ...A to swallow.
        db      !CODE_X
org $b23f2
        ; Amazing. You can use the energy beam by pushing Y.
        db      !CODE_B
org $b25e0
        ; When Kirby is wearing an ability cap, push A.
        db      !CODE_X
org $b2634
        ; Push A again.
        db      !CODE_X
org $b2932
        ; Push A one more time and the helper will become the ability cap.
        db      !CODE_X
org $b2a3c
        ; To slide, Push Down and B together.
        db      !CODE_A
org $b3187
        ; Y button makes kirby suck up an enemy.
        db      !CODE_B
org $b31e1
        ; B button makes kirby jump
        db      !CODE_A
org $b3234
        ; Push Y to inhale enemies.
        db      !CODE_B
org $b3258
        ; Press A to swallow enemies...
        db      !CODE_X
org $b3292
        ; The A Button will also create a helper...
        db      !CODE_X
