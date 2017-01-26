#!/bin/bash

# Если файл index_new.html не существует значит он почему то не был
# сгенерирован, что очень плохо. Скрипт упал.
if [ ! -f "index_new.html" ]; then
	exit
fi

# Если файл index.html не существует, то создадим его из index_new.html.
# Откроем этот файл в браузере
if [ ! -f "index.html" ]; then
	cp index_new.html index.html
  	firefox index.html	
# index.html существует
else
	# Проверяем изменился ли файл.
	# Если файл изменился то перезагружаем его в браузере.
	# Плагин firefox remote-control должен быть установлен
	RESULT=`diff index.html index_new.html`
	if [ ! -z "$RESULT" ]; then 
		cp index_new.html index.html
		echo reload | nc 127.0.0.1 32000 
	fi

 fi
