
import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../widgets/produto_card.dart';
import 'detalhes_produto_screen.dart';

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  final List<Produto> _produtos = [
    const Produto(
      id: '1',
      nome: 'Smartphone Galaxy S24',
      preco: 4500.00,
      categoria: 'Eletrônicos',
      icone: '📱',
    ),
    const Produto(
      id: '2',
      nome: 'Notebook Dell XPS',
      preco: 8900.00,
      categoria: 'Informática',
      icone: '💻',
    ),
    const Produto(
      id: '3',
      nome: 'Fone Bluetooth Sony',
      preco: 1200.00,
      categoria: 'Áudio',
      icone: '🎧',
    ),
    const Produto(
      id: '4',
      nome: 'Smartwatch Garmin',
      preco: 2300.00,
      categoria: 'Wearables',
      icone: '⌚',
    ),
    const Produto(
      id: '5',
      nome: 'Teclado Mecânico RGB',
      preco: 450.00,
      categoria: 'Periféricos',
      icone: '⌨️',
    ),
  ];

  int _proximoId = 6;

  void _adicionarProduto() {
    final novoProduto = Produto(
      id: _proximoId.toString(),
      nome: 'Novo Produto $_proximoId',
      preco: 100.00,
      categoria: 'Acessórios',
      icone: '📦',
    );

    setState(() {
      _produtos.add(novoProduto);
      _proximoId++;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Produto adicionado com sucesso!'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _removerProduto(Produto produto) {
    setState(() {
      _produtos.removeWhere((item) => item.id == produto.id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${produto.nome} removido'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _abrirDetalhes(Produto produto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalhesProdutoScreen(
          produto: produto,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Produtos'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'Itens: ${_produtos.length}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _produtos.isEmpty
          ? const Center(
              child: Text('Nenhum produto cadastrado'),
            )
          : ListView.builder(
              itemCount: _produtos.length,
              itemBuilder: (context, index) {
                final produto = _produtos[index];

                return Dismissible(
                  key: ValueKey(produto.id),
                  direction: DismissDirection.horizontal,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  onDismissed: (direction) {
                    _removerProduto(produto);
                  },
                  child: ProdutoCard(
                    produto: produto,
                    onTap: () => _abrirDetalhes(produto),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarProduto,
        child: const Icon(Icons.add),
      ),
    );
  }
}