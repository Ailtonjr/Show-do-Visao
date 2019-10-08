programa
{
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
	inteiro imagem_fundo_menu = 0, imagem_fundo_cenario = 0, imagem_LogotipoPS = 0

	//Variável que armazena o arquivo das perguntas e respostas
	inteiro arquivo_perguntas
	//Caminho do arquivo que contém as perguntas e respostas
	cadeia caminho_do_arquivo = "./perguntas.txt"
	
	funcao inicio()
	{
		inicializar()
		
		enquanto (tela_atual !=  TELA_SAIR){	
			escolha (tela_atual){
				
				caso TELA_MENU		: 	tela_menu()		pare
				caso TELA_JOGO		: 	tela_jogo() 		pare
				/*caso TELA_ACERTO	: 	tela_acerto() 		pare
				caso TELA_ERRO		: 	tela_derrota() 	pare*/
			}
		}
		
		finalizar()
	}

	funcao inicializar(){
		
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_titulo_janela("Show do Visão")
		g.definir_dimensoes_janela(LARGURA_TELA, ALTURA_TELA)
		
		carregar_imagens()
		carregar_fontes()
		Carregar_arquivo()
	}

	funcao carregar_imagens(){
		cadeia diretorio_imagens ="./Imagens/"

		imagem_LogotipoPS = g.carregar_imagem(diretorio_imagens + "portugol.png")
		imagem_fundo_menu = g.carregar_imagem(diretorio_imagens + "fundoMenu.jpg")
		imagem_fundo_cenario = g.carregar_imagem(diretorio_imagens + "Show-do-visao2.png")
	}

	funcao carregar_fontes(){
		cadeia diretorio_fontes ="./fontes/"

		g.carregar_fonte(diretorio_fontes + "poetsen_one_regular.ttf")
		g.carregar_fonte(diretorio_fontes + "Starjedi.ttf")
		g.carregar_fonte(diretorio_fontes + "Starjhol.ttf")
	}

	funcao Carregar_arquivo(){
		//Abrir o arquivo em "MODO_LEITURA"
		arquivo_perguntas = a.abrir_arquivo(caminho_do_arquivo, a.MODO_LEITURA)
	}

	funcao finalizar()
	{
		liberar_imagens()
		//a.fechar_arquivo(
		g.encerrar_modo_grafico()
	}

	funcao liberar_imagens()
	{
		g.liberar_imagem(imagem_fundo_cenario)
		g.liberar_imagem(imagem_fundo_menu)
		g.liberar_imagem(imagem_LogotipoPS)
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

		//g.desenhar_imagem(0, 0, imagemFundoMenu)
		g.definir_fonte_texto("Star Jedi Hollow")
		g.definir_cor(g.COR_BRANCO)
		g.definir_tamanho_texto(120.0)
		
		desenhar_texto_centralizado("Show", 75)
		desenhar_texto_centralizado("do", 180)
		desenhar_texto_centralizado("Visão", 300)
		g.definir_tamanho_texto(20.0)
		g.definir_fonte_texto("Poetsen One")
		g.definir_cor(g.COR_BRANCO)
		desenhar_texto_centralizado("Utilize as teclas A, B, C e D para responder", pos_opcoes + 275)
		g.definir_fonte_texto("Star Jedi")
		g.definir_cor(g.COR_BRANCO)
		
		desenhar_texto_centralizado("Pressione ENTER para iniciar", pos_opcoes + 90)
		desenhar_texto_centralizado("Pressione ESC para sair", pos_opcoes + 120)		
		g.desenhar_imagem(575, 25, imagem_LogotipoPS)
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
		enquanto (tela_atual == TELA_JOGO)
		{
			ler_controles_do_usuario()
			desenhar_tela_do_jogo()

			se (t.tecla_pressionada(t.TECLA_ESC))
			{
				tela_atual = TELA_MENU
			}
		}
	}

	funcao desenhar_tela_do_jogo()
	{		
		g.desenhar_imagem(0, 0, imagem_fundo_cenario)
		g.desenhar_imagem(1000, 850, imagem_LogotipoPS)


		//Teste texto fixo para definir tamanho
		g.definir_tamanho_texto(40.0)
		g.definir_fonte_texto("Poetsen One")
		g.definir_cor(g.COR_VERMELHO)
		g.desenhar_texto(95, 100, "Normalmente, quantos litros de sangue uma pessoa tem?")
		g.desenhar_texto(95, 150, "Em média, quantos são retirados numa doação de sangue?")
		g.desenhar_texto(95, 200, "Teste 3º linha")

		g.definir_tamanho_texto(32.0)
		//OPÇÃO A
		g.desenhar_texto(190, 375, "Tem entre 2 a 4 litros.")
		g.desenhar_texto(190, 410, "São retirados 450 mililitros.")
		//OPÇÃO B
		g.desenhar_texto(190, 515, "Tem entre 4 a 6 litros.")
		g.desenhar_texto(190, 550, "São retirados 450 mililitros.")
		//OPÇÃO C
		g.desenhar_texto(190, 655, "Tem 10 litros.")
		g.desenhar_texto(190, 690, "São retirados 2 litros.")
		//OPÇÃO D
		g.desenhar_texto(190, 795, "Tem 0,5 litros.")
		g.desenhar_texto(190, 830, " São retirados 0,5 litros.")
		
		g.renderizar()
	}
	
	funcao desenhar_texto_centralizado(cadeia texto, inteiro y)
	{
		g.desenhar_texto((LARGURA_TELA/2) - (g.largura_texto(texto) / 2), y, texto)
	}

	funcao ler_controles_do_usuario()
	{	
		
		se (t.tecla_pressionada(t.TECLA_A)){
	     	
	     }se (t.tecla_pressionada(t.TECLA_B)){
			
		}se (t.tecla_pressionada(t.TECLA_C)){
			
		}senao se (t.tecla_pressionada(t.TECLA_D)){
			
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 3926; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */