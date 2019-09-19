programa
{
	inclua biblioteca Graficos --> g
	inclua biblioteca Teclado --> t
	inclua biblioteca Util --> u


	// Constantes para definir as dimensões da tela do jogo
	const inteiro LARGURA_TELA = 800, ALTURA_TELA = 600

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
				/*caso TELA_JOGO		: 	tela_jogo() 		pare
				caso TELA_ACERTO	: 	tela_acerto() 		pare
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
		//carregarSons()
		//carregar_placar()
		//carregar_fontes()
	}

	funcao finalizar(){
		
	}

	funcao carregar_imagens(){
		cadeia diretorio_imagens ="./Imagens/"
		
		imagemFundoMenu = g.carregar_imagem(diretorio_imagens + "fundo.jpg")
		imagemFundoCenario = g.carregar_imagem(diretorio_imagens + "fundo.jpg")
	}

	funcao tela_menu(){
		
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 1247; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */