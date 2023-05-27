part of 'components.dart';

class KonfirmasiDataCard extends StatelessWidget {
  const KonfirmasiDataCard({
    Key? key,
    required this.resiModel,
  }) : super(key: key);

  final ResiModel resiModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nama Penerima',
              style: tPoppins.copyWith(
                color: Color(0xFF656565),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                resiModel.nama,
                style: tPoppins.copyWith(
                  color: cBlack1,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.end,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'No Resi',
              style: tPoppins.copyWith(
                color: Color(0xFF656565),
              ),
            ),
            Text(
              resiModel.resi,
              style: tPoppins.copyWith(
                color: cBlack1,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pembayaran COD',
              style: tPoppins.copyWith(
                color: Color(0xFF656565),
              ),
            ),
            Text(
              NumberFormat.currency(
                      locale: "id_ID", decimalDigits: 0, symbol: "Rp ")
                  .format(int.parse(resiModel.hargaCod)),
              style: tPoppins.copyWith(
                color: cBlack1,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        SizedBox(height: 10),
        Divider(
          color: Color(0xFFF5F6FA),
          thickness: 2,
        ),
        SizedBox(height: 17),
      ],
    );
  }
}
