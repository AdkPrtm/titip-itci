part of 'components.dart';

class BelumDiTerimaTab extends StatefulWidget {
  const BelumDiTerimaTab({Key? key}) : super(key: key);

  @override
  _BelumDiTerimaTabState createState() => _BelumDiTerimaTabState();
}

class _BelumDiTerimaTabState extends State<BelumDiTerimaTab> {
  ScrollController _scrollController = ScrollController();
  late ResiBloc _resiBloc;

  @override
  void initState() {
    super.initState();
    _resiBloc = context.read<ResiBloc>();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<ResiBloc, ResiState>(
          builder: (context, state) {
            // Resi is initialize
            if (state is ResiInitial) {
              return Center(child: CircularProgressIndicator());
            }

            // Resi is loaded
            if (state is ResiBelumDiTerimaLoaded) {
              if (state.items.isEmpty)
                return Center(
                  child: Text("No Resi"),
                );

              return Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                      itemCount: state.hasReachedMax
                          ? state.items.length
                          : state.items.length + 1,
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        if (index >= state.items.length) return BottomLoader();
                        return GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      actionsPadding: EdgeInsets.only(
                                          left: 10, right: 10, bottom: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      title: SvgPicture.asset(
                                        svgTrash,
                                        width: 40,
                                        height: 40,
                                      ),
                                      content: Text(
                                        'Apakah yakin ingin menghapus resi?',
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: cRed,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    context
                                                        .read<ResiBloc>()
                                                        .add(
                                                          DeleteResiEvent(
                                                            resi: state
                                                                .items[index]
                                                                .resi,
                                                          ),
                                                        );
                                                    _resiBloc
                                                      ..add(
                                                          ResiBelumDiTerimaRefresh());
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Hapus',
                                                    style: tPoppins.copyWith(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: cBlue,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: tPoppins.copyWith(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: CardDataComponent(
                                resiModel: state.items[index]));
                      }),
                ),
              );
            }

            // post is error
            return Center(child: Text("Error Fetched Posts"));
          },
        ),
        SizedBox(height: 50),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    _resiBloc..add(ResiBelumDiTerimaRefresh());
  }

  void _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) _resiBloc..add(ResiBelumDiTerimaFetch());
  }
}
