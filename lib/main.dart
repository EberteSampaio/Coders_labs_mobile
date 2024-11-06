import 'package:flutter/material.dart';
import 'src/view/ticket_list_page.dart';
import 'src/view/about_page.dart';
import 'src/view/create_ticket_page.dart';
import 'src/view/profile_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    CreateTicketPage(),
    TicketListPage(),
    ProfilePage(),
    AboutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Helpdesk App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[800],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Cadastrar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Listar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Sobre o App',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.blue[800],
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
/*
class CreateTicketPage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cadastrar Ticket',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Título',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Descrição',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              String title = titleController.text;
              String description = descriptionController.text;
              if (title.isNotEmpty && description.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Ticket cadastrado com sucesso!')),
                );
                titleController.clear();
                descriptionController.clear();
              }
            },
            child: Text('Cadastrar Ticket'),
          ),
        ],
      ),
    );
  }
}
*/

/*
class TicketListPage extends StatelessWidget {
  final List<Map<String, String>> tickets = [
    {
      'title': 'Problema com o login',
      'description': 'Não consigo acessar o sistema.'
    },
    {
      'title': 'Erro na tela de relatórios',
      'description': 'A tela de relatórios não carrega os dados corretamente.'
    },
    {
      'title': 'Solicitação de novo acesso',
      'description': 'Preciso de acesso ao sistema de vendas.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(tickets[index]['title']!),
          subtitle: Text(tickets[index]['description']!),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TicketDetailPage(ticket: tickets[index]),
              ),
            );
          },
        );
      },
    );
  }
}
*/
/*
class TicketDetailPage extends StatelessWidget {
  final Map<String, String> ticket;

  TicketDetailPage({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Ticket'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Título: ${ticket['title']}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Descrição:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              ticket['description']!,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: 100,
            color: Colors.blue[600],
          ),
          SizedBox(height: 20),
          Text(
            'Perfil do Usuário',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
*/
/*
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Versão do App: 1.0.0',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {},
            child: Text('Política de Privacidade'),
          ),
          TextButton(
            onPressed: () {  },
            child: Text('Termos de Uso'),
          ),
          TextButton(
            onPressed: () {  },
            child: Text('Contato de Suporte'),
          ),
        ],
      ),
    );
  }
}
*/
