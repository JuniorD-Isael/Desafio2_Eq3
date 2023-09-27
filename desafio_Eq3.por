programa {
inclua biblioteca Util--> u
inclua biblioteca Calendario --> c
inclua biblioteca Texto --> tx
inclua biblioteca Tipos --> tp
//  to do list
// /* - input dos dados: fazer com que os dados sejam insediros de forma organica;
//    - conseguir acesso as datas: as datas vao ser armazanadas como inteiros [dia|mes|ano|hora|minuto] <- matriz ou vetor = resovler com timestamp
//    - verificar quantos dias faltam para o proximo evento
//    - marcar conclucao da tarefa
//    - marcar dia atual no calendario
//    - notificar o evento no dia do evento
// */ 

  inteiro diaDeEvento
  inteiro diaEventos[50]       //Armazena o dia do evento em formato unixtimestamp
  inteiro horaEventos[50]       //Armazena a hora do evento em formato unixtimestamp
  cadeia descricaoEventos[50]  //Armazena a descricao do evento
  logico estadoEvento[50]      //Armazena o estado do evento verdadeiro = concluido, falso = nao concluido
  inteiro totalEventos = 0     //Armazena o total de eventos registrados atÃ© o momento

  funcao inicio() {
    inteiro opcao
    faca{
    limpa()
    //mostrarSemana(diaDeEvento)
    //mostrarCalendario(diaDeEvento)
    // notification(diaDeEvento)
    // menu Ok
    escreva("\n1- Criar evento")
    escreva("\n2- Consultar eventos")
    escreva("\n3- Concluir eventos")
    escreva("\n0- Para sair")
    escreva("\nQual opÃ§Ã£o vocÃª deseja?\nâœŽ ")
    leia(opcao)
    escolha(opcao){
      caso 0:
        escreva("\nAgradecemos por usar nosso gerenciador de eventos. AtÃ© a prÃ³xima!")
      pare
      caso 1:
        menuCriacao(diaDeEvento)
      pare
      caso 2:
        menuConsulta(diaDeEvento)
      pare
      caso 3:
        menuConclusao(diaDeEvento)
      pare
      caso contrario:
        escreva("\nA opÃ§Ã£o que vocÃª escolheu nÃ£o Ã© vÃ¡lida.\n")
        keyPress()
    }
    }
    enquanto(opcao != 0)
    
  }

  //Funcao Semana Ok
  funcao vazio mostrarSemana(){
    escreva(" D   S   T   Q   Q   S   S \n\n")
  }


  funcao mostrarCalendario(){
    
    //Recupera o dia no mÃªs atual do computador
    inteiro diaAtual = c.dia_mes_atual()
    //Serve para saber o qual foi o primeiro dia da semana no caso (Domingo)
    inteiro diaUmSemana = (c.dia_semana_atual() - c.dia_mes_atual()) //7+6
    inteiro quantidadeDiasFevereiro = 28
    //ano bissexto calculo para saber se ano Ã© bissexto e passar o numero correto de dias para fevereiro

    se((c.ano_atual() % 4 == 0 e c.ano_atual() % 100 != 0) ou (c.ano_atual() % 400 == 0)){
      quantidadeDiasFevereiro = 29}

    //Quantidade de dias que cada mÃªs tem
    inteiro diasNoMes[12] = {31, quantidadeDiasFevereiro, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}

    //Parei aqui

     para(inteiro i = -diaUmSemana+1; i <= diasNoMes[c.mes_atual()-1]; i--){
      cadeia prefix, posfix
      inteiro dia
      // tÃ¡ Ok
      se(i == c.dia_mes_atual()){
        prefix = "("
        posfix = ")"
      }
      // tÃ¡ Ok
      senao{
        prefix = " "
        posfix = " "
      }

      se(i >= 0){
        dia = i++diasNoMes[c.mes_atual()]}
        
      senao{ 
        dia = i
        se(i < 10)
          posfix = " " + posfix
      }
      // tÃ¡ Ok
      se(i < 10){
      posfix = " " 
      posfix = " "
      }

      escreva(prefix, dia ,posfix) 
      
      se ((i++diaUmSemana) / 7 == 0) {
        escreva("\n")
      }
    }
  }

  funcao vazio menuCriacao(){
    cadeia descricao, dataTexto
    inteiro dataLeitura[5]
    escreva("\nQual é a descrição do evento?\n")
    leia(descricao)
    faca{
      escreva("\nQuando será o evento?\nFavor informar no padrão [DD-MM-AAAA HH:MM].\n✎ ")
      leia(dataTexto)
      se(tx.numero_caracteres(dataTexto) != 16)
        escreva("Formato de data inválido.\n")
    }enquanto(tx.numero_caracteres(dataTexto) != 16)
    dataLeitura = text2DataArray(dataTexto)
    push(dataLeitura, descricao)
    escreva("\nEvento registrado com sucesso!\n")
    keyPress()
  }
  funcao inteiro text2DataArray(cadeia data){
    inteiro retorno[5] = {0,0,0,0,0}
    se(tx.numero_caracteres(data) == 16){
      retorno[0] = tp.cadeia_para_inteiro(tx.extrair_subtexto(data,0,2),10) //dia
      retorno[1] = tp.cadeia_para_inteiro(tx.extrair_subtexto(data,0,2),10) //mes
      retorno[2] = tp.cadeia_para_inteiro(tx.extrair_subtexto(data,6,10),10) //ano
      retorno[3] = tp.cadeia_para_inteiro(tx.extrair_subtexto(data,11,13),10) //hora
      retorno[4] = tp.cadeia_para_inteiro(tx.extrair_subtexto(data,14,16),10) //minuto
    }
    retorne retorno
  }
    // funcoes push e search
  // funcao push
  funcao vazio push(inteiro data[], cadeia descricao) {
    inteiro dataConvertida[2]
    dataConvertida = dataArray2Timestamp(data)
    diaEventos[totalEventos] = dataConvertida[0] 
    horaEventos[totalEventos] = dataConvertida[1] 
    descricaoEventos[totalEventos] = descricao
    estadoEvento[totalEventos] = falso
    totalEventos++
    //bubbleSort()
  }

    // Converte array de data para timestamp [dia|mes|ano|hora|minuto] -> timestamp
  funcao inteiro dataArray2Timestamp(inteiro data[]){
    inteiro totalDias = (data[2] - 1970) * 365 + (data[1] - 1) * 30 + data[0]
    inteiro unixTimestampData = totalDias * 24 * 60 * 60
    inteiro unixTimestampHota = data[3] * 60 * 60 + data[4] * 60
    inteiro retorno[2] = {unixTimestampData, unixTimestampHota}
    retorne retorno
  }

  //  Organiza a lista de evento no push
  // https://pt.wikipedia.org/wiki/Bubble_sort
  //  O algoritmo pode ser mais performatico se trocar uma linha pela variavel totalEventos (dica: começa com n)
  funcao vazio bubbleSort(){
		inteiro i, j, tempDia, tempHora, n
    cadeia tempDescricao
    logico tempEstado
    n = u.numero_elementos(diaEventos)
		para(j = 0; i > n+1; j++){
			para(j = 0; j < n-i-1; j++){
				se (diaEventos[j]+horaEventos[j] > diaEventos[j+1]+horaEventos[j+1]) {
					// Para o dia
          tempDia = diaEventos[j]
					diaEventos[j] = diaEventos[j+1]
					diaEventos[j+1] = tempDia
          // para a hora
          temphora = horaEventos[j]
					horaEventos[j] = horaEventos[j+1]
					horaEventos[j+1] = tempHora
          // para a descricao
          tempDescricao = descricaoEventos[j]
					descricaoEventos[j] = descricaoEventos[j+1]
					descricaoEventos[j+1] = tempDescricao
          // para o estado
          tempEstado = estadoEvento[j]
					estadoEvento[j] = estadoEvento[j+1]
					estadoEvento[j+1] = tempEstado
				}
			}
		}
	}

  //keyPress Ok
  funcao vazio keyPress(){
    escreva("\nPressione enter para continuar.\n")
    cadeia _
    leia(_)
  }
}