import 'package:flutter/material.dart';
import 'package:mealsapp/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = 'filter-screen';
  final Function saveFilters;
  final Map<String, bool> filters;

  FiltersScreen(this.filters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenfree = false;
  bool _vegetarian = false;
  bool _lactosefree = false;
  bool _vegan = false;

  @override
  void initState() {
    _glutenfree = widget.filters['gluten'];
    _vegetarian = widget.filters['vegetarian'];
    _lactosefree = widget.filters['lactose'];
    _vegan = widget.filters['vegan '];

    super.initState();
  }

  Widget _switchTileBuilder(
      bool boolean, String title, String subtitle, Function updatVlaue) {
    return SwitchListTile(
      value: boolean,
      onChanged: updatVlaue,
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters'),
          actions: [
            IconButton(
                icon: Icon(Icons.save_rounded),
                onPressed: () {
                  final filterdata = {
                    'gluten': _glutenfree,
                    'lactose': _lactosefree,
                    'vegan': _vegan,
                    'vegetarian': _vegetarian
                  };
                  widget.saveFilters(filterdata);
                })
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection',
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                _switchTileBuilder(_glutenfree, 'Gluten-Free',
                    'Only include gluten-free meals.', (newValue) {
                  setState(() {
                    _glutenfree = newValue;
                  });
                }),
                _switchTileBuilder(
                    _vegetarian, 'Vegetarian', 'Only include vegetarian meals.',
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
                _switchTileBuilder(_lactosefree, 'Lactose-Free',
                    'Only include lactose-free meals.', (newValue) {
                  setState(() {
                    _lactosefree = newValue;
                  });
                }),
                _switchTileBuilder(_vegan, 'Vegan', 'Only include vegan meals.',
                    (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
              ],
            ))
          ],
        ));
  }
}
