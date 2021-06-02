import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestButtom {

  final IconData icon;
  final Function onPressed;

  PinterestButtom({
    @required this.icon,
    @required this.onPressed,
  });

}

class PinterestMenu extends StatelessWidget {

  final bool mostrar;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final List<PinterestButtom> items;

  PinterestMenu({
    this.mostrar = true,
    this.backgroundColor = Colors.white,
    this.activeColor = Colors.black,
    this.inactiveColor = Colors.blueGrey,
    @required this.items
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: AnimatedOpacity(
        opacity: ( mostrar ) ? 1 : 0,
        duration: Duration( milliseconds: 200 ),
        child: Builder(
          builder: (BuildContext context) {

            Provider.of<_MenuModel>(context).backgroundColor = this.backgroundColor;
            Provider.of<_MenuModel>(context).activeColor = this.activeColor;
            Provider.of<_MenuModel>(context).inactiveColor = this.inactiveColor;

            return _PinterestMenuFondo(
              child: _MenuItems( items ),
            );
          },
        ),
      ),
    );
  }
}

class _PinterestMenuFondo extends StatelessWidget {

  final Widget child;

  _PinterestMenuFondo({ @required this.child });

  @override
  Widget build(BuildContext context) {

    Color backgroundColor = Provider.of<_MenuModel>(context).backgroundColor;

    return Container(
      child: child,
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(100)),
        boxShadow: <BoxShadow> [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            spreadRadius: -5
          )
        ]
      ),
    );
  }
}

class _MenuItems extends StatelessWidget {

  final List<PinterestButtom> menuItems;

  _MenuItems( this.menuItems );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(menuItems.length, (index) => _PinterestMenuButton(index, menuItems[index])),
    );
  }
}

class _PinterestMenuButton extends StatelessWidget {

  final int index;
  final PinterestButtom item;

  _PinterestMenuButton( this.index, this.item );

  @override
  Widget build(BuildContext context) {

    final itemSeleccionado = Provider.of<_MenuModel>(context).itemSeleccionado;

    final menuModel = Provider.of<_MenuModel>(context);

    return GestureDetector(
      onTap: () {
        Provider.of<_MenuModel>(context, listen: false).itemSeleccionado = index;
        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
        child: Container(
          child: Icon( 
            item.icon,
            size: ( itemSeleccionado == index ) ? 35 : 25,
            color: ( itemSeleccionado == index ) ? menuModel.activeColor : menuModel.inactiveColor,
          ),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  
  int _itemSeleccionado = 0;

  Color backgroundColor = Colors.white;
  Color activeColor = Colors.black;
  Color inactiveColor = Colors.blueGrey;

  int get itemSeleccionado => this._itemSeleccionado;

  set itemSeleccionado ( int index ) {
    this._itemSeleccionado = index;
    notifyListeners();
  }

}