part of 'components.dart';

class CardDataComponent extends StatelessWidget {
  const CardDataComponent({
    Key? key,
    required this.resiModel,
  }) : super(key: key);

  final ResiModel resiModel;

  @override
  Widget build(BuildContext context) {
    final String formated = DateFormat.yMMMEd().format(resiModel.updateAt);
    return Container(
      margin: EdgeInsets.only(
        top: 12,
        left: 23,
        right: 23,
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(1, 0), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            resiModel.resi,
            style: tPoppins.copyWith(
              color: cBlack1,
              fontSize: 12,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                resiModel.nama,
                style: tPoppins.copyWith(
                  color: cGrey,
                  fontSize: 12,
                ),
              ),
              Text(
                resiModel.posisi,
                style: tPoppins.copyWith(
                  color: cBlack1,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formated,
                style: tPoppins.copyWith(
                  color: cGrey,
                  fontSize: 12,
                ),
              ),
              Text(
                resiModel.status,
                style: tPoppins.copyWith(
                  color: resiModel.status == 'Belum diambil' ? cRed : cGreen,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
