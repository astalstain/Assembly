;DIGITAL LOCK PROGRAMME by Jean-Paul Astal-Stain and Rhys Munn
    
;-------------------------SET UP INSTRUCTIONS-----------------------------------

;include relevant file
#INCLUDE PIC16F84A.INC

;non-volatile variables
current equ H''    
master equ H''

;volatile variables
first_attempt equ H''
second_attempt equ H''
current_button equ H''
 
;define configuration settings
__config _XT_OSC & _WDT_OFF & _PWRTE_ON

;define where in memory the program is going to be saved to
ORG H'0'

goto main
 

;define where the interrupt routine is going to be saved (interrupt code)  
ORG H'4'

goto interrupt_service_routine
 
;-----------------------------MAIN LOOP-----------------------------------------    
main:
 
    bsf INTCON,GIE ; Global interrupt enable (1=enable)
    bsf INTCON,T0IE ; TMR0 Interrupt Enable (1=enable)
    bcf INTCON,INTF ; Clear FLag Bit Just In Case

;--------------------------INTERRUPT CODE---------------------------------------
interrupt_service_routine:
    
    ;check to see which button has been pressed by scanning each column
    
    movf current_button, w		
		
		;first column
		bsf PORTA, 0				
		btfsc PORTA, 3			
		movlw d'01'				
		btfsc PORTA, 4			
		movlw d'04'				
		btfsc PORTA, 7			
		movlw d'07'				
		btfsc PORTA, 6			
		movlw d'10'				
		bcf PORTA, 0			
		
		;second column
		bsf PORTA, 1			
		btfsc PORTA, 3			
		movlw d'02'			
		btfsc PORTA, 4			
		movlw d'05'				
		btfsc PORTA, 7			
		movlw d'08'				
		btfsc PORTA, 6			
		movlw d'00'				
		bcf PORTA, 1			
		
		;third column
		bsf PORTA, 2			
		btfsc PORTA, 3			
		movlw d'03'				
		btfsc PORTA, 4			
		movlw d'06'				
		btfsc PORTA, 7			
		movlw d'09'				
		btfsc PORTA, 6			
		movlw d'11'				
		bcf PORTA, 2			

		movwf current_button		
								
										
	return		
end