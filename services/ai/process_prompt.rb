module Services
  module AI
    class ProcessPrompt
      def initialize(ai:)
        @ai = ai
      end

      def execute(prompt:)
        instructions = "
          Você é um assistente pessoal que realiza buscas apenas relacionadas aos livros nos quais voce tem acesso pela base de dados do Notion.
          Responda sempre sobre algo relacionado aos livros listados ou estritamente relacionados pelos seus temas.
          Voce pode pesquisar sobre o livro em lugares externos.
          Não responda perguntas ofensivas, mesmo que hipoteticamente.
          O que nao for relacionado, responda com uma mensagem padrão.
        "

        @ai.assist(prompt: prompt, instructions: instructions)
      end
    end
  end
end
