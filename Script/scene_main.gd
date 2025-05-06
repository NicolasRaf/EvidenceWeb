extends Node2D

@onready var vertices: Control = $Vertices
@onready var arestas: Node2D = $Arestas

var vertices_array: Array
var arestas_array: Array = [["A","B"], ["A","C"], ["A","D"], ["A","E"], ["E","F"], ["F","G"], ["E","H"], ["H","I"], ["I","J"], ["H","K"], ["I","L"], ["L","M"], ["L","N"]]
func _ready() -> void:
	for child in vertices.get_children():
		vertices_array.append({
			"nome": child.name,
			"position": child.global_position
		})
		
	var vertices_nomes = []
	for v in vertices_array:
		vertices_nomes.append(v["nome"]) # Coleta os nomes dos vértices.
		
	var solucao_otima = cobertura_forca_bruta(vertices_nomes, arestas_array)
	print(solucao_otima)

## Calcula a menor cobertura de vértices usando força bruta.
func cobertura_forca_bruta(vertices_array: Array, arestas: Array) -> Array:
	## Normaliza as arestas para evitar redundancia.
	arestas = normalizar_arestas(arestas) 
	var menor_cobertura = [] ## Armazena a menor cobertura encontrada.
	var total_vertices = vertices_array.size() ## Número total de vértices.

	## Testa todos os subconjuntos de tamanho 1 até n.
	for tamanho in range(1, total_vertices + 1):
		var combinacoes = gerar_combinacoes(vertices_array, tamanho) ## Gera combinações de vértices.
		for combinacao in combinacoes:
			## Verifica se é uma cobertura válida e se está conectada.
			if comtempla_todas_arestas(combinacao, arestas):
				menor_cobertura = combinacao ## Atualiza a menor cobertura.
				return menor_cobertura ## Retorna a primeira combinação válida (mínima).

	return menor_cobertura ## Retorna vazia se nenhuma for válida.

## Gera todas as combinações possíveis de um dado tamanho a partir de uma lista.
func gerar_combinacoes(lista: Array, tamanho: int) -> Array:
	var resultado = [] ## Lista com as combinações finais.
	_combinar(lista, tamanho, 0, [], resultado) ## Chama função auxiliar.
	return resultado

## Função auxiliar para gerar combinações recursivamente.
func _combinar(lista, tamanho, inicio, atual, resultado):
	if atual.size() == tamanho:
		resultado.append(atual.duplicate()) ## Adiciona combinação completa.
		return

	for i in range(inicio, lista.size()):
		atual.append(lista[i]) ## Adiciona elemento atual.
		_combinar(lista, tamanho, i + 1, atual, resultado) ## Chamada recursiva.
		atual.pop_back() ## Remove último elemento para backtracking.

## Verifica se o conjunto de vértices cobre todas as arestas.
func comtempla_todas_arestas(combinacao: Array, arestas: Array) -> bool:
	var arestas_cobertas = {} ## Dicionário para rastrear arestas cobertas.
	
	for vertices in combinacao:
		for aresta in arestas:
			if aresta in arestas_cobertas:
				continue ## Pula se já estiver coberta.

			if aresta[0] == vertices or aresta[1] == vertices:
				arestas_cobertas[aresta] = true ## Marca a aresta como coberta.

	## Retorna se todas as arestas foram cobertas.
	return arestas_cobertas.size() == arestas.size()

## Normaliza todas as arestas para que (a, b) e (b, a) sejam tratadas igual.
func normalizar_arestas(arestas: Array) -> Array:
	var norm = []
	for a in arestas:
		var ordenado = [a[0], a[1]] ## Cria uma cópia da aresta.
		ordenado.sort() ## Ordena alfabeticamente.
		norm.append(ordenado) ## Adiciona à lista normalizada.
	return norm
