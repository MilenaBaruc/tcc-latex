# Passo a Passo: Compilar TCC LaTeX com Docker

## 1️⃣ Entrar no projeto

Abra o terminal no VS Code ou no Mac e vá para a pasta do seu projeto:

```bash
cd ~/Desktop/TCC/tcc-latex
```

## 2️⃣ Build da imagem Docker (uma vez só ou quando atualizar o Dockerfile)

```bash
docker compose build latex
```

* Cria a imagem com todos os pacotes do LaTeX.

## 3️⃣ Limpar arquivos antigos (opcional, mas recomendado)

```bash
docker compose run latex bash -c 'cd latex && make clean'
```

* Apaga PDFs antigos e arquivos temporários.
* Mantém seu template intacto.

## 4️⃣ Compilar o PDF

```bash
docker compose run latex bash -c 'cd latex && make all'
```

ou com `latexmk` direto:

```bash
docker compose run latex bash -c 'cd latex && latexmk -pdf -interaction=nonstopmode -synctex=1 tcc.tex'
```

* PDF novo será gerado em `latex/tcc.pdf`.

## 5️⃣ Visualizar o PDF

* Abra `latex/tcc.pdf` no visualizador de PDF favorito.
* Alterações nos arquivos `.tex` são refletidas automaticamente.

## 6️⃣ Editar os arquivos

* Arquivos principais:

```bash
latex/editaveis/*.tex   # Conteúdo do TCC
latex/fixos/*.tex       # Template (geralmente não mexer)
latex/figuras/          # Imagens
```

* Edite no VS Code normalmente.

## 7️⃣ Workflow rápido enquanto edita

1. Edita arquivos no VS Code
2. Roda `make all` no container → PDF atualizado
3. Se precisar limpar: `make clean` no container

## 8️⃣ Dica de VS Code: rodar com atalho

* Crie `.vscode/tasks.json`:

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Build TCC PDF",
            "type": "shell",
            "command": "docker compose run latex bash -c 'cd latex && make all'",
            "group": "build",
            "problemMatcher": []
        },
        {
            "label": "Clean TCC PDF",
            "type": "shell",
            "command": "docker compose run latex bash -c 'cd latex && make clean'",
            "group": "build",
            "problemMatcher": []
        }
    ]
}
```

* Depois, aperte **`Cmd + Shift + B`** → escolha **Build TCC PDF** → PDF compilado automaticamente.

---

💡 Dica: todas as alterações nos arquivos `.tex` são vistas pelo container automaticamente, porque a pasta do projeto está montada como bind mount.
