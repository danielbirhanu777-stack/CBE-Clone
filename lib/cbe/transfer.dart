import 'package:flutter/material.dart';

class pgetransfer extends StatefulWidget {
  const pgetransfer({Key? key}) : super(key: key);

  @override
  State<pgetransfer> createState() => _pgetransferState();
}

class _pgetransferState extends State<pgetransfer> {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    accountController.dispose();
    nameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void openDemoTransfer(String transferType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _DemoTransferForm(transferType: transferType),
      ),
    );
  }

  Widget transferTile(String title, String subtitle) {
    return ListTile(
      onTap: () => openDemoTransfer(title),
      trailing: const Icon(Icons.navigate_next, color: Colors.purple),
      leading: const Icon(Icons.mobile_friendly,
          color: Colors.purple, size: 35),
      title: Text(title,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.blue[800])),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          Center(
            child: Text('አማ', style: TextStyle(color: Colors.purple)),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(Icons.refresh, color: Colors.purple),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text('Transfer', style: TextStyle(fontSize: 20)),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.amber.shade100,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'DEMO MODE ONLY — no real money is sent.',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            transferTile('Transfer To CBEBirr Wallet',
                'Bank to CBE Birr wallet transfer'),
            const Divider(indent: 50, thickness: 2),
            transferTile('Make Payment to Beneficiary',
                'Transfer to your beneficiaries'),
            const Divider(indent: 50, thickness: 2),
            transferTile('Transfer to CBE Account', 'Transfer to CBE Account'),
            const Divider(indent: 50, thickness: 2),
            transferTile('Local Money Transfer',
                'Transfer to any non-CBE customer'),
            const Divider(indent: 50, thickness: 2),
            transferTile('Donation', 'Donation'),
            const Divider(indent: 50, thickness: 2),
            transferTile(
                'Own Account Transfer', 'Transfer between your accounts'),
            const Divider(indent: 50, thickness: 2),
            transferTile('Transfer to own Telebirr Wallet',
                'Transfer to own Telebirr Wallet'),
            const Divider(indent: 50, thickness: 2),
            transferTile(
                'Transfer to other banks', 'Transfer to other banks'),
          ],
        ),
      ),
    );
  }
}

class _DemoTransferForm extends StatefulWidget {
  final String transferType;

  const _DemoTransferForm({required this.transferType});

  @override
  State<_DemoTransferForm> createState() => _DemoTransferFormState();
}

class _DemoTransferFormState extends State<_DemoTransferForm> {
  final _formKey = GlobalKey<FormState>();
  final accountController = TextEditingController();
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  @override
  void dispose() {
    accountController.dispose();
    nameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void showConfirmation() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _DemoReceiptPage(
          transferType: widget.transferType,
          account: accountController.text.trim(),
          receiver: nameController.text.trim(),
          amount: amountController.text.trim(),
        ),
      ),
    );
  }

  InputDecoration decoration(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo Transfer')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.amber.shade100,
                padding: const EdgeInsets.all(12),
                child: const Text(
                  'DEMO ONLY — this screen does not connect to CBE or send money.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Text(widget.transferType,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextFormField(
                controller: accountController,
                keyboardType: TextInputType.number,
                decoration: decoration('Receiver account number'),
                validator: (value) =>
                    value == null || value.trim().isEmpty
                        ? 'Enter an account number'
                        : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: decoration('Receiver name'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter the receiver name'
                    : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: decoration('Amount (ETB)'),
                validator: (value) {
                  final amount = double.tryParse(value ?? '');
                  if (amount == null || amount <= 0) {
                    return 'Enter a valid amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: showConfirmation,
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  padding: const EdgeInsets.all(15),
                ),
                child: const Text('Continue to demo receipt'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DemoReceiptPage extends StatelessWidget {
  final String transferType;
  final String account;
  final String receiver;
  final String amount;

  const _DemoReceiptPage({
    required this.transferType,
    required this.account,
    required this.receiver,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo Receipt')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.red.shade100,
              padding: const EdgeInsets.all(14),
              child: const Text(
                'DEMO ONLY — NOT A REAL BANK TRANSACTION\nSIMULATED — NO MONEY SENT',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 25),
            const Icon(Icons.receipt_long, size: 55, color: Colors.purple),
            const SizedBox(height: 20),
            Text('Transfer type: $transferType'),
            const Divider(),
            Text('Receiver name: $receiver'),
            const Divider(),
            Text('Account number: $account'),
            const Divider(),
            Text('Amount: $amount ETB'),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'This is a sample screen for testing the app only. It is not proof of payment.',
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.popUntil(
                  context, (route) => route.isFirst),
              child: const Text('Back to transfer menu'),
            ),
          ],
        ),
      ),
    );
  }
}
