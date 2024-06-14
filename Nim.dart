import 'dart:io';

//Aqui, o código está solicitando para o jogador escolher um dos modos de jogo, seja single player ou multiplayer.
void main() {
  print("Bem-vindo! está pronto para ser desafiado no jogo Nim?");

  print("Escolha o modo de jogo:");
  print("1 - Single Player (contra o computador)");
  print("2 - Multiplayer (contra um amigo)");
  
  //essa linha nos apresenta uma função, sendo ela obterNumeroValido, onde ela valida as opções que o usuario irá escolher, entre elas: 1 e 2.
  int modo = obterNumeroValido("Digite 1 ou 2: ", 1, 2);

  // Aqui é a entrada de quantos palitos o jogador podera escolher para serem dispostos pela partida!! obterNumeroValido está validando a entrada do jogador.
  int totaldePalitos = obterNumeroValido(
      "Informe quantos palitos serão dispostos na partida!! (entre 5 e 33): ", 5, 33);

  // Nessa parte, mostro que o jogador podera escolher o numero MAXIMO de palitos que poderão ser retirados pela partida.
  int maxRetirada = obterNumeroValido(
      "Escolha o numero de palitos que poderão ser retirados pela partida (3 e 5): ", 3, 5);

  //aqui é uma inicialização booleana, para fazer o controle da vez de cada jogador, o TRUE indica que é a vez do jogador 1.
  bool vezDoJogador1 = true;

  // Aqui começa o looping do jogo, onde ele sempre vai continuar se restar mais de um palito.
  while (totaldePalitos > 1) {
    print("\nPalitos que sobraram: $totaldePalitos");

    //escolha do modo single player.
    if (modo == 1) {
      if (vezDoJogador1) {

        //Breve código explicando a vez do jogador. Sempre utilizando a função obterNumeroValido para validar a entrada.
        int palitosRetirados = obterNumeroValido(
            "Quantos palitos você deseja retirar? (1 a $maxRetirada): ", 1, maxRetirada, totaldePalitos);

        //Subtrai o número de palitos retirados pelo jogador do total de palitos restantes no jogo.
        totaldePalitos -= palitosRetirados;
        print("Você retirou $palitosRetirados palitos.");
      } else {
        
        // Jogada do computador
        //(totaldePalitos - 1): Subtrai 1 do total de palitos restantes para evitar pegar o último palito, pois quem pegar o último palito perde.
        // % (maxRetirada + 1): Aplica o operador módulo (%) com (maxRetirada + 1) para garantir que o número de palitos retirados esteja dentro do intervalo permitido.
        int palitosRetirados = (totaldePalitos - 1) % (maxRetirada + 1);

        //isso aqui é uma saida, porque dependendo do calculo do módulo pode resultar em 0, e não queremos isso. então toda vez que o resultado do calculo for 0 ele declara como um, para sempre o computador retirar pelo menos 1 palito.
        if (palitosRetirados == 0) {
          palitosRetirados = 1;
        }

        //Subtrai o número de palitos retirados pelo computador do total de palitos restantes no jogo.
        totaldePalitos -= palitosRetirados;
        print("O computador retirou $palitosRetirados palitos.");
      }
      vezDoJogador1 = !vezDoJogador1;
    } else {
      
      // Jogada dos jogadores no modo multiplayer.
      // segue basicamente a mesma logica do single player.
      // a diferença é que não precisamos definir calculo.
      if (vezDoJogador1) {
        int palitosRetirados = obterNumeroValido(
            "Jogador 1, quantos palitos você quer retirar? (1 a $maxRetirada): ", 1, maxRetirada, totaldePalitos);
        totaldePalitos -= palitosRetirados;
        print("Jogador 1 retirou $palitosRetirados palitos.");
      } else {
        int palitosRetirados = obterNumeroValido(
            "Jogador 2, quantos palitos você quer retirar? (1 a $maxRetirada): ", 1, maxRetirada, totaldePalitos);
        totaldePalitos -= palitosRetirados;
        print("Jogador 2 retirou $palitosRetirados palitos.");
      }

      //Alterna a vez do jogador. Se vezDoJogador1 for true, será definido como false, e vice-versa. Isso é feito usando o operador de negação !, que inverte o valor booleano.
      vezDoJogador1 = !vezDoJogador1;
    }

    //Declarações de vitória ou derrota (dependendo da mensagem)

    //se total de palitos no final for == a 1 no modo single player.
    if (totaldePalitos == 1) {
      if (modo == 1) {

        //se restar um palito na vez do jogador um, consequentemente ele perdeu.
        if (vezDoJogador1) {
          print("Que pena, parece que você perdeu, pois restou somente o ultimo palito.");

        //se não, ele ganhou.
        } else {
          print("Que gratificante, parece que você venceu até mesmo a maquina né!?");
        }

        //aqui são condições de vitória no modo multiplayer.
      } else {

        //se na vez do jogador 1 restar apenas um palito, quer dizer que o jogador 2 foi o vencedor.
        if (vezDoJogador1) {
          print("Parabéns jogador 2! você acaba de massacrar o jogador 1! Restou apenas um palito.");

          //se não, jogador 1 foi o vencedor.
        } else {
          print("Parece que ele não foi um desafio para você! Jogador 1...\n você é demais! Restou apenas um palito.");
        }
      }
      
      //aqui encessa o looping quando o jogo chegar ao fim.
      break;
    }
  }

  //printa a mensagem de Game Over
  print("Game Over");
}

// String para definir uma mensagem
// Definições do valor minimo e maximo, caso não seja fornecido o valor total de palitos restantes, se não for fornecido é -1.
int obterNumeroValido(String mensagem, int min, int max, [int totaldePalitos = -1]) {

  //variaveis do tipo int? (inteiro opcional) e String? (String opcional).
  int? numero;
  String? entrada;

  //looping do-while que continua até uma entrada for valida.
  do {

    //exibe mensagem de orientação.
    print(mensagem);

    //le a entrada apartir do console, e armazena em entrada.
    entrada = stdin.readLineSync();

    //verifica se a entrada não é nula e não esta vazia.
    if (entrada != null && entrada.isNotEmpty) {

      //conversão da entrada em numero inteiro, caso não seja possivel, a entrada ficara como nulo.
      numero = int.tryParse(entrada);

      //verificação se o numero digitado é valido. 
      //se estra dentre o limite minimo e maximo permitido e se totalPalitos não for o valor padrão -1, também verifica se numero é menor ou igual ao total de palitos restantes menos 1.
      if (numero != null && numero >= min && numero <= max && (totaldePalitos == -1 || numero < totaldePalitos)) {

        //depois que todas essas condições forem atendidas, ele retorna o numero.
        return numero;
      }
    }

    // mensagens de erro quando o jogador querer retirar mais palitos do que permitido ou tentar uma quantidade invalida.
    if (numero == null || numero < min || numero > max) {
      print("Você digitou algo que não devia, por favor insira um número entre $min e $max.");
    } else if (totaldePalitos != -1 && numero >= totaldePalitos) {
      print("Você não pode retirar o mesmo número de palitos que o restante. Insira um número entre 1 e ${totaldePalitos - 1}.");
    }

    //fim do loopinh do-while.
  } while (true);
}
