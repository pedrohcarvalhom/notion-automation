## Notion AI assistent

The main idea for this project is to get know better some AI tools for ruby.

### How it works?

To run it localy, you have to set three variables

- OPENAI_API_KEY=
- NOTION_API_KEY=

Here its the [Notion Website](https://developers.notion.com/docs/create-a-notion-integration) that shows how to create a integration with databases or pages

### Tools used

- Sinatra for HTTP
- Langchain as adapter for AI requests (I'm using OpenAI)
- Faraday to make HTTP Requests

### How to

- Run application: `make serve`
- Make a request: You just have to send a POST request to the /ai_books endpoint, sending the body like this:

```json
{
  "prompt": "List for me the tasks for this table {id}"
}
```

Caveats:

- For now, you need to send your database/page ID, so that we can fetch the data and answer correctly the question.

TODO:

- Search for resumes
- Speech-to-Text
