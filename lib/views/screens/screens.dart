import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:titip_itci/bloc/cart_bloc.dart';
import 'package:titip_itci/bloc/resi_bloc.dart';
import 'package:titip_itci/bloc/user_bloc.dart';
import 'package:titip_itci/models/models.dart';
import 'package:titip_itci/shared/shared.dart';
import 'package:titip_itci/views/components/components.dart';
import 'package:url_launcher/url_launcher.dart';

part 'login_screens.dart';
part 'main_screens.dart';
part 'home_screen.dart';
part 'history_screen.dart';
part 'add_resi_screen.dart';
part 'confirmation_screen.dart';
part 'splash_screen.dart';