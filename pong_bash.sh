#!/bin/bash

#Iniciar el juego
run=1

#Puntaje (iniciales)
score_1=0
score_2=0

#Limites de la pantalla
lim_left=1
lim_right=100
lim_up=1
lim_down=50

#Posicion del jugador 1 (iniciales)
posx=2
posy=50
tam=7
left_c=$(($posy))
right_c=$(($posy + $tam))

#Posicion del jugador 2 (iniciales - bot)
posx_2=49
posy_2=50
tam_2=7
left_c2=$(($posy_2))
right_c2=$(($posy_2 + $tam_2))
mov_left_bot=-1

#Posicion pelota (iniciales)
posx_p=25
posy_p=50
mov_up_p=1
mov_left_p=1

while [ $run -eq 1 ]
do
	#Clear y puntaje
	echo -ne '\0033\0143 \e[48;5;0m'
	echo -en "\033[${posx_p};${posy_p}H \e[48;5;0m o"
	echo -en "\033[9;110H \e[48;5;0m Pong" 
	echo -en "\033[10;110H \e[48;5;0m Puntaje 1 : ${score_1}"
	echo -en "\033[11;110H \e[48;5;0m Puntaje 2 : ${score_2}"
	#Bordes pantalla
	for((i=lim_up;i<lim_down;i++))
	do
		echo -en "\033[${i};${lim_left}H \e[48;5;0m |"
		echo -en "\033[${i};${lim_right}H \e[48;5;0m |"
	done
	#Tablas
	echo -en "\033[${posx};${posy}H \e[48;5;0m #######"
	echo -en "\033[${posx_2};${posy_2}H \e[48;5;0m #######"
	#GameOver
	if [ $score_1 -eq 7 ]; then
		run=0
		echo -en "\033[19;110H \e[48;5;0m Gano el Jugador 1"
		echo -en "\033[20;110H \e[48;5;0m Pulse cualquier tecla para salir"
		read -s KEY
	elif [ $score_2 -eq 7 ]; then
		run=0
		echo -en "\033[19;110H \e[48;5;0m Gano el Jugador 2"
		echo -en "\033[20;110H \e[48;5;0m Pulse cualquier tecla para salir"
		read -s KEY
	fi
	#Pelota
	if [ $posx_p -le $(($lim_up + 1)) ];then
		score_2=$(($score_2 + 1))
		mov_up_p=$(($mov_up_p * -1))
		posx_p=25
		posy_p=50
	elif [ $posx_p -ge $(($lim_down - 1)) ];then
		score_1=$(($score_1 + 1))
		mov_up_p=$(($mov_up_p * -1))
		posx_p=25
		posy_p=50
	fi
	if [ $posx_p -eq $(($posx + 1)) ] && [ $posy_p -ge $left_c ] && [ $posy_p -le $right_c ];then
		mov_up_p=$(($mov_up_p * -1))
	fi
	if [ $posx_p -eq $(($posx_2 - 1)) ] && [ $posy_p -ge $left_c2 ] && [ $posy_p -le $right_c2 ];then
		mov_up_p=$(($mov_up_p * -1))
	fi
	if [ $posy_p -le $(($lim_left + 1)) ];then
		mov_left_p=$(($mov_left_p * -1))
	elif [ $posy_p -ge $(($lim_right - 1)) ];then
		mov_left_p=$(($mov_left_p * -1))
	fi
	posx_p=$(($posx_p + $mov_up_p))
	posy_p=$(($posy_p + $mov_left_p))
	#Jugador 1
	read -s -n 1 -t 0.3 KEY
	case $KEY in
		C) 
			#echo -e "RIGHT"
			if [ $right_c -le $lim_right ]; then
				posy=$(($posy + 1))
			fi
			;;
			
		D) 
			#echo -e "LEFT"
			if [ $left_c -ge $lim_left ]; then
				posy=$(($posy - 1))
			fi
			;;
	esac
	left_c=$(($posy))
	right_c=$(($posy + $tam))
	#Jugador 2
	if [ $right_c2 -eq $(($lim_right - 1)) ]; then
		mov_left_bot=$(($mov_left_bot * -1))
	elif [ $left_c2 -eq $(($lim_left + 1)) ]; then
		mov_left_bot=$(($mov_left_bot * -1))
	fi
	posy_2=$(($posy_2 + $mov_left_bot))
	left_c2=$(($posy_2))
	right_c2=$(($posy_2 + $tam_2))
	
done

#Salir del juego
echo -ne '\0033\0143 \e[48;5;0m'
exit 0
	
