.PHONY: help coverage coverage-report coverage-open test clean

# Variáveis
COVERAGE_DIR = coverage
COVERAGE_FILE = $(COVERAGE_DIR)/lcov.info
COVERAGE_HTML = $(COVERAGE_DIR)/html
COVERAGE_INDEX = $(COVERAGE_HTML)/index.html

# Comando padrão
help:
	@echo "Comandos disponíveis:"
	@echo "  make coverage        - Gera relatório de cobertura e abre no navegador"
	@echo "  make coverage-report - Apenas gera o relatório HTML"
	@echo "  make coverage-open   - Abre o relatório HTML existente"
	@echo "  make test            - Executa todos os testes"
	@echo "  make clean           - Remove arquivos de build e cobertura"

# Gera cobertura, cria relatório HTML e abre no navegador
coverage:
	@echo "🧪 Executando testes com cobertura..."
	@fvm flutter test --coverage
	@echo "📊 Gerando relatório HTML..."
	@if command -v genhtml > /dev/null; then \
		genhtml $(COVERAGE_FILE) -o $(COVERAGE_HTML) --no-function-coverage --no-branch-coverage && \
		echo "✅ Relatório gerado em: $(COVERAGE_HTML)/index.html" && \
		echo "🌐 Abrindo relatório no navegador..." && \
		open $(COVERAGE_INDEX) 2>/dev/null || xdg-open $(COVERAGE_INDEX) 2>/dev/null || \
		echo "Abra manualmente: $(COVERAGE_INDEX)"; \
	else \
		echo "❌ Erro: genhtml não encontrado. Instale com: brew install lcov"; \
		exit 1; \
	fi

# Gera o relatório de cobertura e o HTML
coverage-report:
	@echo "🧪 Executando testes com cobertura..."
	@fvm flutter test --coverage
	@echo "📊 Gerando relatório HTML..."
	@if command -v genhtml > /dev/null; then \
		genhtml $(COVERAGE_FILE) -o $(COVERAGE_HTML) --no-function-coverage --no-branch-coverage; \
		echo "✅ Relatório gerado em: $(COVERAGE_HTML)/index.html"; \
	else \
		echo "❌ Erro: genhtml não encontrado. Instale com: brew install lcov"; \
		exit 1; \
	fi

# Abre o relatório HTML no navegador
coverage-open:
	@if [ -f $(COVERAGE_INDEX) ]; then \
		echo "🌐 Abrindo relatório no navegador..."; \
		open $(COVERAGE_INDEX) 2>/dev/null || xdg-open $(COVERAGE_INDEX) 2>/dev/null || \
		echo "Abra manualmente: $(COVERAGE_INDEX)"; \
	else \
		echo "❌ Relatório não encontrado. Execute 'make coverage-report' primeiro."; \
		exit 1; \
	fi

# Executa todos os testes
test:
	@echo "🧪 Executando testes..."
	@fvm flutter test

# Remove arquivos de build e cobertura
clean:
	@echo "🧹 Limpando arquivos de build e cobertura..."
	@fvm flutter clean
	@rm -rf $(COVERAGE_DIR)
	@echo "✅ Limpeza concluída"

