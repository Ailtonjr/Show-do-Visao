programa
{
	inclua biblioteca Texto --> tx
	inclua biblioteca Arquivos --> a
	inclua biblioteca Graficos --> g
	inclua biblioteca Teclado --> t
	inclua biblioteca Util --> u

	// O projetor deve estar em 1024 * 768 para que funcione corretamente.
	// Constantes para definir as dimensões da tela do jogo
	const inteiro LARGURA_TELA = 1280, ALTURA_TELA = 920

	// Constantes para definir as telas do jogo 
	const inteiro TELA_SAIR = 0, TELA_MENU = 1, TELA_JOGO = 2, TELA_ACERTO = 3, TELA_ERRO = 4

	// Variável para controlar as telas do jogo
	inteiro tela_atual = TELA_MENU

	//Variáveis que armazenam o endereço de memória das imagens utilizadas no jogo
	inteiro imagem_fundo_jogo = 0, imagem_logotipo_PS = 0, imagem_logotipo_visao = 0, imagem_select = 0, imagem_acerto = 0, imagem_erro = 0

	// Variavel que armazena a cor do fundo
	inteiro cor_fundo = g.criar_cor(0, 49, 104)

	// Caminho do arquivo que contém as perguntas e respostas
	cadeia caminho_do_arquivo = "./perguntas.txt"

	// Variável que armazena o arquivo das perguntas e respostas
	inteiro arquivo_perguntas

	// Variáveis que armazenam as perguntas e respostas a serem exibidas
	cadeia pergunta_linha1 = "", pergunta_linha2 = "", resposta_A = "", resposta_B = "", resposta_C = "", resposta_D = ""
	caracter resposta_correta = '*', caracter tecla_pressionada = ' '

	/*
	 * Função que inicializa o jogo e responsável pelo controle geral de telas;
	*/
	funcao inicio()
	{
		inicializar()
		// O Game Loop é controlado através da váriavel tela_atual.
		// Quando ela muda de estado, acontecem as mudanças de tela.
		enquanto (tela_atual !=  TELA_SAIR){	
			escolha (tela_atual){
				caso TELA_MENU		: 	tela_menu()		pare
				caso TELA_JOGO		: 	tela_jogo() 		pare
				caso TELA_ACERTO	: 	tela_acerto() 		pare
				caso TELA_ERRO		: 	tela_erro() 		pare
			}
		}
		finalizar()
	}

	/*
	 * Função que inicializa o modo gráfico;
	*/
	funcao inicializar(){
		
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_titulo_janela("Jogo do Visão")
		g.definir_dimensoes_janela(LARGURA_TELA, ALTURA_TELA)
		
		carregar_imagens()
		carregar_fontes()
	}

	/*
	 * Função que carrega as imagens na pasta das imagens;
	*/
	funcao carregar_imagens(){
		cadeia diretorio_imagens ="./Imagens/"

		imagem_logotipo_PS = g.carregar_imagem(diretorio_imagens + "portugol.png")
		imagem_fundo_jogo = g.carregar_imagem(diretorio_imagens + "fundoJogo.png")
		imagem_logotipo_visao = g.carregar_imagem(diretorio_imagens + "visao.png")
		imagem_acerto = g.carregar_imagem(diretorio_imagens + "acerto.png")
		imagem_erro = g.carregar_imagem(diretorio_imagens + "erro.png")
	}

	/*
	 * Função que carrega as fontes na pasta das fontes;
	*/
	funcao carregar_fontes(){
		cadeia diretorio_fontes ="./fontes/"

		g.carregar_fonte(diretorio_fontes + "Kapsalon.otf")
		g.carregar_fonte(diretorio_fontes + "poetsen_one_regular.ttf")
	}

	/*
	 * Função que encerra o modo gráfico;
	*/
	funcao finalizar()
	{
		liberar_imagens()
		g.encerrar_modo_grafico()
	}

	/*
	 * Função que libera o espaço de memória onde a imagem estava armazenada;
	*/
	funcao liberar_imagens()
	{
		g.liberar_imagem(imagem_fundo_jogo)
		g.liberar_imagem(imagem_logotipo_PS)
		g.liberar_imagem(imagem_logotipo_visao)
		g.liberar_imagem(imagem_acerto)
		g.liberar_imagem(imagem_erro)
	}

	/*
	* Função que controla a tela do menu;
	*/
	funcao tela_menu()
	{
		enquanto (tela_atual == TELA_MENU){	
			desenhar_tela_menu()
			navegacao_tela_menu()
		}
	}

	/*
	 * Função que cria a tela do menu, e a renderiza;
	*/
	funcao desenhar_tela_menu(){
		// Variável que guarda a posição base do eixo Y das opções.
		inteiro pos_opcoes = 540
		
		g.definir_cor(cor_fundo)
		g.limpar()
		
		g.definir_fonte_texto("Kapsalon DEMO")
		g.definir_cor(g.COR_BRANCO)
		g.definir_tamanho_texto(120.0)
		desenhar_texto_centralizado("Jogo", 75)
		desenhar_texto_centralizado("do", 180)
		desenhar_texto_centralizado("Visão", 300)
		
		// Desenhar o retangulo do logo visão
		g.desenhar_retangulo(500, 530, 300, 100, verdadeiro, verdadeiro)
		g.desenhar_imagem(560, 530, imagem_logotipo_visao)

		g.definir_fonte_texto("Poetsen One")
		g.definir_tamanho_texto(24.0)
		desenhar_texto_centralizado("Pressione ENTER para iniciar", pos_opcoes + 180)
		desenhar_texto_centralizado("Pressione ESC para sair", pos_opcoes + 210)
		
		desenhar_texto_centralizado("Utilize as teclas A, B, C e D para responder", pos_opcoes + 315)

		g.desenhar_imagem(535, 25, imagem_logotipo_PS)
		g.renderizar()
	}

	/*
	* Função que controla a navegação da tela do menu;
	*/
	funcao navegacao_tela_menu()
	{		
		se (t.tecla_pressionada(t.TECLA_ENTER))
		{
			tela_atual = TELA_JOGO
		}
		senao se (t.tecla_pressionada(t.TECLA_ESC))
		{
			tela_atual = TELA_SAIR
		}
	}

	/*
	* Função que controla a tela do jogo;
	*/
	funcao tela_jogo()
	{	
		se (tela_atual == TELA_JOGO)
		{
			desenhar_tela_do_jogo()
			ler_controles_do_usuario()
		}
	}

	/*
	 * Função que cria a tela do jogo, e a renderiza;
	*/
	funcao desenhar_tela_do_jogo()
	{		
		// Variável que guarda a posição base do eixo Y das respostas.
		inteiro pos_y_respostas = 392
		g.desenhar_imagem(0, 0, imagem_fundo_jogo)
		g.desenhar_imagem(1000, 850, imagem_logotipo_PS)

		sortear_pergunta()
		
		// Formata e escreve as perguntas na tela.
		g.definir_tamanho_texto(40.0)
		g.definir_fonte_texto("Poetsen One")
		g.definir_cor(g.COR_VERMELHO)
		g.desenhar_texto(95, 100, pergunta_linha1)
		g.desenhar_texto(95, 150, pergunta_linha2)

		// Formata e escreve as respostas na tela.
		g.definir_tamanho_texto(32.0)
		g.desenhar_texto(190, pos_y_respostas, resposta_A)
		g.desenhar_texto(190, pos_y_respostas + 140, resposta_B)
		g.desenhar_texto(190, pos_y_respostas + 280, resposta_C)
		g.desenhar_texto(190, pos_y_respostas + 420, resposta_D)

		g.renderizar()
	}

	/*
	* Função que controla a tela de acerto;
	*/
	funcao tela_acerto(){
		se (tela_atual == TELA_ACERTO)
		{
			desenhar_tela_acerto()
			u.aguarde(4000)
			tela_atual = TELA_JOGO
		}
	}

	/*
	 * Função que cria a tela de acerto, e a renderiza;
	*/
	funcao desenhar_tela_acerto(){
		g.definir_cor(cor_fundo)
		g.limpar()
		g.desenhar_imagem(400, 200, imagem_acerto)

		g.definir_cor(g.criar_cor(0, 167, 13))
		g.definir_tamanho_texto(40.0)
		g.definir_fonte_texto("Poetsen One")
		desenhar_texto_centralizado("Resposta correta: " + resposta_correta, 660)
		g.renderizar()
	}

	/*
	* Função que controla a tela de erro;
	*/
	funcao tela_erro(){
		se (tela_atual == TELA_ERRO)
		{
			desenhar_tela_erro()
			u.aguarde(4000)
			tela_atual = TELA_JOGO
		}
	}

	/*
	 * Função que cria a tela de erro, e a renderiza;
	*/
	funcao desenhar_tela_erro(){
		g.definir_cor(cor_fundo)
		g.limpar()
		g.desenhar_imagem(400, 200, imagem_erro)
		
		g.definir_cor(g.criar_cor(190, 27, 92))
		g.definir_tamanho_texto(40.0)
		g.definir_fonte_texto("Poetsen One")
		desenhar_texto_centralizado("Resposta correta: " + resposta_correta, 660)

		g.renderizar()
	}

	/*
	 * Função que desenhas o texto centralizado na tela.
	 * Essa função leva em consideração a largura da tela e o tamanho do texto;
	 * 
	 * @Parametros
	 * 
	 * texto - texto a ser escrito;
	 * y - posição (altura) onde o texto será desenhado;
	*/
	funcao desenhar_texto_centralizado(cadeia texto, inteiro y)
	{
		g.desenhar_texto((LARGURA_TELA/2) - (g.largura_texto(texto) / 2), y, texto)
	}

	/*
	 * Função que faz a leitura dos controles do jogo;
	*/
	funcao ler_controles_do_usuario()
	{	
		/* 
		 * Atribui "espaço" como valor e verifica se uma das teclas do jogo fo pressionada;
		 * A função só continua se for pressionado "A", "B", "C", "D" ou "Esc"; 
		*/
		tecla_pressionada = ' '
		faca{
			se (t.tecla_pressionada(t.TECLA_A)){
		     	tecla_pressionada = 'A'
		     }senao se (t.tecla_pressionada(t.TECLA_B)){
				tecla_pressionada = 'B'
			}senao se (t.tecla_pressionada(t.TECLA_C)){
				tecla_pressionada = 'C'
			}senao se (t.tecla_pressionada(t.TECLA_D)){
				tecla_pressionada = 'D'
			}senao se (t.tecla_pressionada(t.TECLA_ESC)){
				tecla_pressionada = '*'
			}
		}enquanto(tecla_pressionada != 'A' e tecla_pressionada != 'B' e tecla_pressionada != 'C' e tecla_pressionada != 'D' e tecla_pressionada != '*')

		// Troca para a tela correspontente ao estado do jogo (acerto/erro) ou para a tela MENU;
		se (t.tecla_pressionada(t.TECLA_ESC)){
			tela_atual = TELA_MENU
		}senao se (tecla_pressionada == resposta_correta){
			tela_atual = TELA_ACERTO
		}senao{
			tela_atual = TELA_ERRO
		}
		// Aguarda 200ms para que não acabe fechando a tela do MENU também;
		u.aguarde(200)
	}

	/*
	 * Função que verifica qual a resposta correta que foi extraida do arquivo de texto;
	*/
	funcao encontrar_resposta_correta(){
		/* 
		 *  Usamos a função da bilbioteca de texto para primeiramente verificar se o primeiro caracter é o "*"
		 *  e depois para extrair o restante da resposta correta (exceto o *), sobrescrevendo-a.
		 */
		se(tx.obter_caracter(resposta_A, 0) == '*'){
			resposta_A = tx.extrair_subtexto(resposta_A, 1, tx.numero_caracteres(resposta_A))
			resposta_correta = 'A'
		}senao se(tx.obter_caracter(resposta_B, 0) == '*'){
			resposta_B = tx.extrair_subtexto(resposta_B, 1, tx.numero_caracteres(resposta_B))
			resposta_correta = 'B'
		}senao se(tx.obter_caracter(resposta_C, 0) == '*'){
			resposta_C = tx.extrair_subtexto(resposta_C, 1, tx.numero_caracteres(resposta_C))
			resposta_correta = 'C'
		}senao se(tx.obter_caracter(resposta_D, 0) == '*'){
			resposta_D = tx.extrair_subtexto(resposta_D, 1, tx.numero_caracteres(resposta_D))
			resposta_correta = 'D'
		}

		//Log: escreva ("\n\nresposta correta é: ", resposta_correta, "\n\n")
	}

	/*
	 * Função que sorteia uma pergunta e guarda ela e as suas respectivas respostas;
	*/
	funcao sortear_pergunta(){
		// Sorteia um numero entre 0 e 39 e multiplica por 6 para definir a linha correspondente a pergunta;
		inteiro num_pergunta = ((u.sorteia(0, 119) * 6))
		// Abre o arquivo das perguntas em modo leitura;
		arquivo_perguntas = a.abrir_arquivo(caminho_do_arquivo, a.MODO_LEITURA)

		// Percorre as lindas do arquivo até a linha desejada
		para(inteiro i=1; i <= num_pergunta; i++){
			a.ler_linha(arquivo_perguntas)
		}
		// Faz uma leitura das duas linhas das perguntas e suas 4 possíveis respostas;
		pergunta_linha1 = a.ler_linha(arquivo_perguntas)
		pergunta_linha2 = a.ler_linha(arquivo_perguntas)
		resposta_A = a.ler_linha(arquivo_perguntas)
		resposta_B = a.ler_linha(arquivo_perguntas)
		resposta_C = a.ler_linha(arquivo_perguntas)
		resposta_D = a.ler_linha(arquivo_perguntas)

		// Log: escreva(pergunta_linha1,"\n", resposta_A,"\n", resposta_B,"\n", resposta_C,"\n", resposta_D)
		encontrar_resposta_correta()
		// Por último fecha o arquivo das perguntas para que zere o índice do arquivo para procurar a próxima pergunta;
		a.fechar_arquivo(arquivo_perguntas)
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 9836; 
 * @DOBRAMENTO-CODIGO = [56, 69, 82, 92, 101, 124, 156, 224, 239, 273, 281, 317];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */