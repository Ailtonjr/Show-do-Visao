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
		
	funcao inicio()
	{
		inicializar()
		// O Game Loop é controlado através da váriavel tela_atual.
		// Quando ela muda de estado, acontecem as mudanças de tela
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

	funcao inicializar(){
		
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_titulo_janela("Jogo do Visão")
		g.definir_dimensoes_janela(LARGURA_TELA, ALTURA_TELA)
		
		carregar_imagens()
		carregar_fontes()
	}

	funcao carregar_imagens(){
		cadeia diretorio_imagens ="./Imagens/"

		imagem_logotipo_PS = g.carregar_imagem(diretorio_imagens + "portugol.png")
		imagem_fundo_jogo = g.carregar_imagem(diretorio_imagens + "fundoJogo.png")
		imagem_logotipo_visao = g.carregar_imagem(diretorio_imagens + "visao.png")
		imagem_acerto = g.carregar_imagem(diretorio_imagens + "acerto.png")
		imagem_erro = g.carregar_imagem(diretorio_imagens + "erro.png")
	}

	funcao carregar_fontes(){
		cadeia diretorio_fontes ="./fontes/"

		g.carregar_fonte(diretorio_fontes + "Kapsalon.otf")
		g.carregar_fonte(diretorio_fontes + "poetsen_one_regular.ttf")
	}

	funcao finalizar()
	{
		liberar_imagens()
		g.encerrar_modo_grafico()
	}

	funcao liberar_imagens()
	{
		g.liberar_imagem(imagem_fundo_jogo)
		g.liberar_imagem(imagem_logotipo_PS)
		g.liberar_imagem(imagem_logotipo_visao)
		g.liberar_imagem(imagem_acerto)
		g.liberar_imagem(imagem_erro)
	}

	funcao tela_menu()
	{
		enquanto (tela_atual == TELA_MENU){	
			desenhar_tela_menu()
			navegacao_tela_menu()
		}
	}

	funcao desenhar_tela_menu(){
		inteiro pos_opcoes = 540
		// Define a cor do fundo
		g.definir_cor(cor_fundo)
		g.limpar()
		
		g.definir_fonte_texto("Kapsalon DEMO")
		g.definir_cor(g.COR_BRANCO)
		g.definir_tamanho_texto(120.0)
		
		desenhar_texto_centralizado("Jogo", 75)
		desenhar_texto_centralizado("do", 180)
		desenhar_texto_centralizado("Visão", 300)

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

	funcao tela_jogo()
	{	
		se (tela_atual == TELA_JOGO)
		{
			desenhar_tela_do_jogo()
			ler_controles_do_usuario()
		}
	}

	funcao desenhar_tela_do_jogo()
	{		
		inteiro pos_y_respostas = 392
		sortear_pergunta()
		g.desenhar_imagem(0, 0, imagem_fundo_jogo)
		g.desenhar_imagem(1000, 850, imagem_logotipo_PS)


		//Teste texto fixo para definir tamanho
		g.definir_tamanho_texto(40.0)
		g.definir_fonte_texto("Poetsen One")
		g.definir_cor(g.COR_VERMELHO)
		g.desenhar_texto(95, 100, pergunta_linha1)
		g.desenhar_texto(95, 150, pergunta_linha2)
		//g.desenhar_texto(95, 200, "")

		g.definir_tamanho_texto(32.0)
		//OPÇÃO A
		g.desenhar_texto(190, pos_y_respostas, resposta_A)
		//OPÇÃO B
		g.desenhar_texto(190, pos_y_respostas + 140, resposta_B)
		//OPÇÃO C
		g.desenhar_texto(190, pos_y_respostas + 280, resposta_C)
		//OPÇÃO D
		g.desenhar_texto(190, pos_y_respostas + 420, resposta_D)

		g.renderizar()
	}
	
	funcao tela_acerto(){
		se (tela_atual == TELA_ACERTO)
		{
			desenhar_tela_acerto()
			u.aguarde(2000)
			tela_atual = TELA_JOGO
		}
	}

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

	funcao tela_erro(){
		se (tela_atual == TELA_ERRO)
		{
			desenhar_tela_erro()
			u.aguarde(2000)
			tela_atual = TELA_JOGO
		}
	}

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
	
	funcao desenhar_texto_centralizado(cadeia texto, inteiro y)
	{
		g.desenhar_texto((LARGURA_TELA/2) - (g.largura_texto(texto) / 2), y, texto)
	}

	funcao ler_controles_do_usuario()
	{	
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
		
		se (t.tecla_pressionada(t.TECLA_ESC)){
			tela_atual = TELA_MENU
		}senao se (tecla_pressionada == resposta_correta){
				tela_atual = TELA_ACERTO
				escreva("\n\n##################### Resposta Correta #####################\n\n")
		}senao{
				tela_atual = TELA_ERRO
				escreva("\n\n##################### Resposta Errada #####################\n\n")
		}
		
		u.aguarde(200)
	}

	funcao verifica_resposta_correta(){
		/* Usamos a função da bilbioteca de texto para primeiramente verificar se o primeiro caracter é o *
		 e depois para extrair o restante da resposta correta (exceto o *), sobrescrevendo-a. */
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

		escreva ("\n\nresposta correta é: ", resposta_correta, "\n\n")
	}

	funcao sortear_pergunta(){
		inteiro num_pergunta = ((u.sorteia(0, 39) * 6))
		
		arquivo_perguntas = a.abrir_arquivo(caminho_do_arquivo, a.MODO_LEITURA)
		
		para(inteiro i=0; i < num_pergunta; i++){
			a.ler_linha(arquivo_perguntas)
		}

		pergunta_linha1 = a.ler_linha(arquivo_perguntas)
		pergunta_linha2 = a.ler_linha(arquivo_perguntas)
		resposta_A = a.ler_linha(arquivo_perguntas)
		resposta_B = a.ler_linha(arquivo_perguntas)
		resposta_C = a.ler_linha(arquivo_perguntas)
		resposta_D = a.ler_linha(arquivo_perguntas)

		
		escreva(pergunta_linha1,"\n", resposta_A,"\n", resposta_B,"\n", resposta_C,"\n", resposta_D)
		verifica_resposta_correta()
		a.fechar_arquivo(arquivo_perguntas)
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 2196; 
 * @DOBRAMENTO-CODIGO = [51, 71, 93, 180, 201, 222];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */