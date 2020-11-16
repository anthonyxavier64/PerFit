import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import 'package:perfit_app/dummy_data.dart';

import '../../screens/company_student_screens/company_details_screen.dart';
import '../../models/company.dart';
//import '../../providers/companies_list.dart';

class CompanyWidget extends StatelessWidget {
  /*final String id;

  CompanyWidget(this.id);
  */

  @override
  Widget build(BuildContext context) {
    Company company = Provider.of<Company>(context);

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 17,
          ),
          padding: EdgeInsets.all(3),
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            //color: Theme.of(context).primaryColorDark,
            color: Colors.black54,
          ),
          child: Container(
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Image.asset(
              company.logoURL,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Container(
          height: 30,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            company.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ],
    );
  }
}
