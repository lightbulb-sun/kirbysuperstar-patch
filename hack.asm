!MASK_BUTTON_X      = $0040
!MASK_BUTTON_A      = $0080
!MASK_BUTTON_SELECT = $2000
!MASK_BUTTON_Y      = $4000
!MASK_BUTTON_B      = $8000

!ARROW_BUTTON_DOWN  = $0010
!ARROW_BUTTON_A     = $0040
!ARROW_BUTTON_B     = $0080
!ARROW_BUTTON_X     = $0100
!ARROW_BUTTON_Y     = $0200
!ARROW_TARGET       = $1000
!ARROW_DONUT        = $4000
!ARROW_CANDY        = $8000

!CODE_A             = $4d
!CODE_B             = $4e
!CODE_X             = $64
!CODE_Y             = $65

!TILE_PAUSE_A       = $4a
!TILE_PAUSE_B       = $4b
!TILE_PAUSE_X       = $4c
!TILE_PAUSE_Y       = $4d


sa1rom
; change controls
org $03ed24
        ; rewrite held button presses for player 1
        jsr     rewrite_button_presses
org $03ed30
        ; rewrite new button presses for player 1
        jsr     rewrite_button_presses
org $03ed64
        ; rewrite held button presses for player 2
        jsr     rewrite_button_presses
org $03ed70
        ; rewrite new button presses for player 2
        jsr     rewrite_button_presses

org $03f8d0
rewrite_button_presses:
        php
        phx

        tax
        lda.w   #$0000
        pha

        txa
        and.w   #$3f30
        sta     $01, s
.turn_a_into_b
        txa
        and.w   #!MASK_BUTTON_A
        xba
        ora     $01, s
        sta     $01, s
.turn_b_into_y
        txa
        and.w   #!MASK_BUTTON_B
        lsr
        ora     $01, s
        sta     $01, s
.turn_x_into_a
        txa
        and.w   #!MASK_BUTTON_X
        asl
        ora     $01, s
        sta     $01, s
.turn_y_into_b
        txa
        and.w   #!MASK_BUTTON_Y
        asl
        ora     $01, s
        sta     $01, s
.end
        pla
        plx
        plp
        rts


org $029ad4
        jml     ditch_copy_ability

; ditch copy ability by pressing Select
org $02fa81
ditch_copy_ability:
        pha
        and.w   #!MASK_BUTTON_SELECT
        bne     .pressedSelect
        pla
        and.w   $36b2, y
        clc
        bne     .pressedHelperButton
        jml     $029ada
.pressedHelperButton
        jml     $029af2
.pressedSelect
        pla
        jml     $029b18



; fix arrows
; Short explanation
org $d1d8e7
        dw      !ARROW_BUTTON_B
org $d1d90e
        dw      !ARROW_BUTTON_X
org $d1d92b
        dw      !ARROW_BUTTON_X

; Beginner's Show #1, Jumping
org $d1c2f7
        ; Jump by pushing B.
        dw      !ARROW_BUTTON_A
org $d1c35f
        ; Now let's take the food off the obstacle...
        dw      !ARROW_BUTTON_A|!ARROW_DONUT
org $d1c3f7
        ; Food restores energy.
        dw      !ARROW_BUTTON_A
org $d1c42b
        ; There is food up in the sky.
        dw      !ARROW_BUTTON_A|!ARROW_CANDY

;; Beginner's Show #1, Inhaling
org $d1c54f
        ; By pushing Y, Kirby will inhale almost anything in his path.
        dw      !ARROW_BUTTON_B
org $d1c64c
        ; Now let's practice inhaling an enemy.
        dw      !ARROW_BUTTON_B
org $d1c6a0
        ; Push Y to spit out a star....
        dw      !ARROW_BUTTON_B
org $d1c6ae
        ; ... This is your attack.
        dw      !ARROW_BUTTON_B|!ARROW_TARGET
org $d1be60
        ; This time could be a bit difficult.
        lda     #!ARROW_BUTTON_B
org $d1c888
        ; Jump and spit out a star.
        ; Push A, then B quickly.
        dw      !ARROW_BUTTON_A|!ARROW_BUTTON_B
org $d1c8a4
        ; Jump and spit out a star.
        ; Push A, then B quickly. (cont'd)
        dw      !ARROW_BUTTON_A|!ARROW_BUTTON_B|!ARROW_TARGET


; Beginner's Show #2, Swallow
org $d1cb74
        dw      !ARROW_BUTTON_X
org $d1cc03
        dw      !ARROW_BUTTON_B
org $d1cd9d
        dw      !ARROW_BUTTON_X
org $d1cf1e
        dw      !ARROW_BUTTON_X
org $d1cf61
        dw      !ARROW_BUTTON_X
org $d1cfb0
        dw      !ARROW_BUTTON_B
org $d1cfc8
        dw      !ARROW_BUTTON_X
org $d1d13b
        dw      !ARROW_BUTTON_A|!ARROW_BUTTON_DOWN


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


; fix instructions in pause menu
org $2c9b9f
        ; Inhale an enemy by pushing Y ...
        db      !TILE_PAUSE_B
org $2c9bd4
;       ; ... and swallow it by pushing A.
        db      !TILE_PAUSE_X
org $2ca00e
        ; Press A again to create a helper
        db      !TILE_PAUSE_X
org $2abb74
        ; Y:Inhaling/Spitting out
        db      !TILE_PAUSE_B
org $2abbc8
        ; B:Jump/Hovering
        db      !TILE_PAUSE_A
org $2abbf7
        ; A:Copy an enemy/Make a helper
        db      !TILE_PAUSE_X
org $2ca9e7
        ; Down+B :Sliding
        db      !TILE_PAUSE_A
