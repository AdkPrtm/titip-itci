part of 'screens.dart';

class AddResiScreen extends StatefulWidget {
  const AddResiScreen({Key? key, required this.resi}) : super(key: key);

  @override
  _AddResiScreenState createState() => _AddResiScreenState();
  final String resi;
}

class _AddResiScreenState extends State<AddResiScreen> {
  @override
  void initState() {
    context.read<ResiBloc>().add(SearchResiEvent(resi: widget.resi));
    super.initState();
  }

  final _locations = ['Balikpapan', 'ITCI'];
  final _payment = ['LUNAS', 'COD'];
  final _status = ['Belum diambil', 'Sudah diambil'];
  String? _currentLocations;
  String? _currentPayment;
  String? _currentStatus;
  TextEditingController resiController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController hargaCodController = TextEditingController(text: '0');
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Widget header({String text = 'Tambah Data Pengiriman'}) {
      return Center(
        child: Text(
          text,
          style: tPoppins.copyWith(
            fontSize: 18,
            color: cBlack1,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    Widget formField({ResiModel? resiModel, String? resi}) {
      if (resiModel != null) {
        resiController.text = resiModel.resi;
        namaController.text = resiModel.nama;
        hargaCodController.text = resiModel.hargaCod;
      }
      if (resi != null) {
        resiController.text = resi;
      }
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No Resi',
              style: tPoppins.copyWith(
                color: cBlack1,
              ),
            ),
            FieldComponent(
              hint: 'JPXXXXXX',
              controller: resiController,
              warning: 'nomor resi',
              enable: false,
            ),
            SizedBox(height: 24),
            Text(
              'Nama',
              style: tPoppins.copyWith(
                color: cBlack1,
              ),
            ),
            FieldComponent(
              hint: 'Andhika Pratama',
              controller: namaController,
              warning: 'nama penerima',
              enable: resiModel == null ? true : false,
            ),
            SizedBox(height: 24),
            Text(
              'Pilih Kota',
              style: tPoppins.copyWith(
                color: cBlack1,
              ),
            ),
            DropdownButtonFormField<String>(
              hint: Text('Pilih Kota'),
              value: resiModel == null ? _currentLocations : resiModel.posisi,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              ),
              items: _locations.map((location) {
                return DropdownMenuItem(
                  value: location,
                  child: Text('$location'),
                );
              }).toList(),
              onChanged: (val) => setState(() => _currentLocations = val),
              validator: (val) {
                if (val == null || val == 'Pilih Kota') {
                  return 'Pilih kota dahulu';
                }
                return null;
              },
            ),
            SizedBox(height: 24),
            Text(
              'Metode Pembayaran',
              style: tPoppins.copyWith(
                color: cBlack1,
              ),
            ),
            DropdownButtonFormField<String>(
              hint: Text('Pilih Jenis Pembayaran'),
              value: resiModel == null ? _currentPayment : resiModel.pembayaran,
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    resiModel == null ? cBackground : cGrey.withOpacity(0.2),
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              ),
              items: _payment.map((payment) {
                return DropdownMenuItem(
                  value: payment,
                  child: Text('$payment'),
                );
              }).toList(),
              onChanged: resiModel == null
                  ? (val) => setState(() => _currentPayment = val)
                  : null,
              validator: (val) {
                if (val == null || val == 'Pilih Jenis Pembayaran') {
                  return 'Pilih Jenis Pembayaran dahulu';
                }
                return null;
              },
            ),
            SizedBox(height: 24),
            Text(
              'Harga COD',
              style: tPoppins.copyWith(
                color: cBlack1,
              ),
            ),
            FieldComponent(
              hint: 'Rp ',
              controller: hargaCodController,
              warning: 'Harga COD',
              enable: resiModel != null ? false : true,
              number: true,
            ),
            SizedBox(height: 24),
            Text(
              'Status',
              style: tPoppins.copyWith(
                color: cBlack1,
              ),
            ),
            DropdownButtonFormField<String>(
              hint: Text('Pilih Status'),
              value: resiModel == null ? _currentStatus : resiModel.status,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              ),
              items: _status.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text('$status'),
                );
              }).toList(),
              onChanged: (val) => setState(() => _currentStatus = val),
              validator: (val) {
                if (val == null || val == 'Pilih Status') {
                  return 'Pilih status dahulu';
                }
                return null;
              },
            ),
          ],
        ),
      );
    }

    Widget buttonNext({String? text, ResiModel? resiModel}) {
      return ButtonComponent(
        text: resiModel == null
            ? text!
            : resiModel.posisi == 'Balikpapan'
                ? 'Update Data'
                : 'Selanjutnya',
        color: cBlue,
        onPressed: () {
          if (text == 'Tambah Data Resi') {
            if (_formKey.currentState!.validate() &&
                _currentLocations != null &&
                _currentPayment != null &&
                _currentStatus != null) {
              context.read<ResiBloc>().add(InputResiEvent(
                  nama: namaController.text,
                  resi: resiController.text,
                  posisi: _currentLocations!,
                  status: _currentStatus!,
                  pembayaran: _currentPayment!,
                  hargaCod: hargaCodController.text));
              Navigator.pushNamedAndRemoveUntil(
                  context, '/MainScreen', (route) => false);
            }
          } else if (resiModel!.posisi == 'Balikpapan') {
            if (_formKey.currentState!.validate() &&
                _currentLocations != 'Balikpapan') {
              context.read<ResiBloc>().add(
                  EditPosisiResiEvent(resi: resiModel.resi, posisi: 'Itci'));
              Navigator.pushNamedAndRemoveUntil(
                  context, '/MainScreen', (route) => false);
            }
          } else {
            if (_formKey.currentState!.validate()) {
              context.read<CartBloc>().add(AddToCart(resiModel: resiModel));
              Navigator.pushNamed(context, '/ConfirmationData');
            }
          }
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<ResiBloc, ResiState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is SearchResiSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(text: 'Update Data Pengiriman'),
                  SizedBox(height: 47),
                  formField(resiModel: state.resiModel),
                  Spacer(),
                  buttonNext(resiModel: state.resiModel),
                  SizedBox(height: 16),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(text: 'Tambah Data Pengiriman'),
                  SizedBox(height: 47),
                  formField(resi: widget.resi),
                  Spacer(),
                  buttonNext(text: 'Tambah Data Resi'),
                  SizedBox(height: 16),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    resiController.dispose();
    namaController.dispose();
    hargaCodController.dispose();
    super.dispose();
  }
}
