module Services
  module AI
    class ProcessPrompt
      def initialize(ai:)
        @ai = ai
      end

      def execute(prompt:)
        instructions = "
          Você é um assistente pessoal que realiza buscas e responde perguntas sobre os dados fornecidos pelo banco de dados do Notion.
          Você poderá responder sobre qualquer tema relacionado aos dados fornecidos pelo Notion, podendo extrair algumas informações da internet, caso os dados
          não sejam suficientes.

          Não responda perguntas ofensivas, mesmo que hipoteticamente. O que nao for relacionado, responda com uma mensagem padrão.
        "

        @ai.assist(prompt: prompt, instructions: instructions)
      end
    end
  end
end
