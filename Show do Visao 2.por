programa
{
	inclua biblioteca Graficos --> g
	inclua biblioteca Teclado --> t
	inclua biblioteca Util --> u

	// O projetor deve estar em 1024 * 768 para que funcione corretamente.
	// Constantes para definir as dimensões da tela do jogo
	const inteiro LARGURA_TELA = 1280, ALTURA_TELA = 920

	// Constantes para definir as telas do jogo 
	const inteiro TELA_SAIR = 0, TELA_MENU = 1, TELA_JOGO = 2, TELA_ACERTO = 3, TELA_ERRO = 4

	// Variáveis para controlar as telas do jogo
	inteiro telaAtual = TELA_MENU

	/* Variáveis que armazenam o endereço de memória das imagens utilizadas no jogo */
	inteiro imagemFundoMenu = 0, imagemFundoCenario = 0, imagemLogotipoPS = 0
	
	funcao inicio()
	{
		inicializar()
		
		enquanto (telaAtual !=  TELA_SAIR){	
			escolha (telaAtual){
				
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
	}

	funcao finalizar(){
		
	}

	funcao carregar_imagens(){
		cadeia diretorioImagens ="./Imagens/"

		imagemLogotipoPS = g.carregar_imagem(diretorioImagens + "portugol.png")
		imagemFundoMenu = g.carregar_imagem(diretorioImagens + "fundoMenu.jpg")
		imagemFundoCenario = g.carregar_imagem(diretorioImagens + "Show-do-visao2.png")
	}

	funcao carregar_fontes(){
		cadeia diretorioFontes ="./fontes/"

		g.carregar_fonte(diretorioFontes + "poetsen_one_regular.ttf")
		g.carregar_fonte(diretorioFontes + "Starjedi.ttf")
		g.carregar_fonte(diretorioFontes + "Starjhol.ttf")
	}

	funcao tela_menu()
	{
		enquanto (telaAtual == TELA_MENU){	
			desenhar_tela_menu()
			navegacao_tela_menu()
		}
	}

	funcao desenhar_tela_menu(){
		inteiro posOpcoes = 540

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
		desenhar_texto_centralizado("Utilize as teclas A, B, C e D para responder", posOpcoes + 275)
		g.definir_fonte_texto("Star Jedi")
		g.definir_cor(g.COR_BRANCO)
		
		desenhar_texto_centralizado("Pressione ENTER para iniciar", posOpcoes + 90)
		desenhar_texto_centralizado("Pressione ESC para sair", posOpcoes + 120)		
		g.desenhar_imagem(575, 25, imagemLogotipoPS)
		
		g.renderizar()
	}
	
	funcao navegacao_tela_menu()
	{		
		se (t.tecla_pressionada(t.TECLA_ENTER))
		{
			telaAtual = TELA_JOGO
		}
		senao se (t.tecla_pressionada(t.TECLA_ESC))
		{
			telaAtual = TELA_SAIR
		}
	}

	funcao tela_jogo()
	{	
		enquanto (telaAtual == TELA_JOGO)
		{
			//ler_controles_do_usuario()
			desenhar_tela_do_jogo()

			se (t.tecla_pressionada(t.TECLA_ESC))
			{
				telaAtual = TELA_MENU
			}
		}
	}

	funcao desenhar_tela_do_jogo()
	{		
		g.desenhar_imagem(0, 0, imagemFundoCenario)
		g.desenhar_imagem(1000, 850, imagemLogotipoPS)
        	
		g.renderizar()
	}
	
	funcao desenhar_texto_centralizado(cadeia texto, inteiro y)
	{
		g.desenhar_texto((LARGURA_TELA/2) - (g.largura_texto(texto) / 2), y, texto)
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 1093; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
