import 'package:cruise_buddy/UI/Screens/payment_steps_screen/select_payment_method.dart';
import 'package:cruise_buddy/UI/Widgets/Button/full_width_bluebutton.dart';
import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class BookingconfirmationScreen extends StatefulWidget {
  const BookingconfirmationScreen({super.key});

  @override
  _BookingconfirmationScreenState createState() =>
      _BookingconfirmationScreenState();
}

class _BookingconfirmationScreenState extends State<BookingconfirmationScreen> {
  int _currentPage = 0;
  String _selectedCruiseType = 'Day Cruise';
  int _numRooms = 2;
  int _day = 1;
  int _numAdults = 2;
  int _numKids = 2;
  DateTime _selectedDate = DateTime(2024, 11, 2);
  String _location = "Kottayam";
  int _nonVegCount = 2;
  int _vegCount = 2;
  int _jainVegCount = 2;
  String _addOns = '';

  final double _chargesForTheDay = 7000;
  final double _tax = 600;
  final double _discounts = 0.0;
  final double _others = 0.0;

  bool _isEditingBoatDetails = false;
  bool _isEditingPassengers = false;
  bool _isEditingDate = false;
  bool _isEditingLocation = false;

  final List<String> _images = [
    'assets/image/boat_details_img/boat_detail_img.png',
    'assets/image/boat_details_img/boat_detail_img.png',
    'assets/image/boat_details_img/boat_detail_img.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
              child:
                  SvgPicture.asset('assets/image/payment_screen/Confirm.svg')),
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              SizedBox(
                height: 210,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _images.length,
                  onPageChanged: (int pageIndex) {
                    setState(() {
                      _currentPage = pageIndex;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Image.asset(_images[index], fit: BoxFit.fill),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 15,
                left: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Color(0xffE2E2E2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${_currentPage + 1}/${_images.length}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildEditableSection(
                  title: 'Boat Details',
                  isEditing: _isEditingBoatDetails,
                  onTap: () => setState(
                      () => _isEditingBoatDetails = !_isEditingBoatDetails),
                  editingWidgets: [
                    DropdownButtonFormField<String>(
                      value: _selectedCruiseType,
                      decoration:
                          const InputDecoration(labelText: 'Cruise Type'),
                      items: <String>[
                        'Day Cruise',
                        'Full Day Cruise',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedCruiseType = newValue;
                          });
                        }
                      },
                    ),
                    _buildNumericInput('No of Rooms', _numRooms,
                        (value) => setState(() => _numRooms = value)),
                    _buildNumericInput(
                        'Day', _day, (value) => setState(() => _day = value)),
                  ],
                  displayWidgets: [
                    _buildDetailRow('Type of Cruise', _selectedCruiseType),
                    _buildDetailRow('No of Rooms', _numRooms.toString()),
                    _buildDetailRow('Day', _day.toString()),
                  ],
                ),

                // Passengers Section
                _buildEditableSection(
                  title: 'Number of passengers',
                  isEditing: _isEditingPassengers,
                  onTap: () => setState(
                      () => _isEditingPassengers = !_isEditingPassengers),
                  editingWidgets: [
                    _buildNumericInput('Adults', _numAdults,
                        (value) => setState(() => _numAdults = value)),
                    _buildNumericInput('Kids', _numKids,
                        (value) => setState(() => _numKids = value)),
                  ],
                  displayWidgets: [
                    _buildDetailRowWithIcon('Adults', _numAdults.toString(),
                        'assets/icons/adult.svg'),
                    _buildDetailRowWithIcon(
                        'Kids', _numKids.toString(), 'assets/icons/kid.svg'),
                  ],
                ),

                // Date
                _buildEditableSection(
                  title: 'Date',
                  isEditing: _isEditingDate,
                  onTap: () => setState(() => _isEditingDate = !_isEditingDate),
                  editingWidgets: [
                    GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          // Check for null here
                          setState(() => _selectedDate = picked);
                        }
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(36),
                            border: Border.all(width: 1)),
                        child: Center(
                          child: Text(
                            DateFormat('dd/MM/yyyy').format(_selectedDate),
                            style: TextStyles.ubuntu16black15w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                  displayWidgets: [
                    _buildDetailRow(
                        'Date', DateFormat('dd/MM/yyyy').format(_selectedDate)),
                  ],
                ),

                // Location Section
                _buildEditableSection(
                  title: 'Location',
                  isEditing: _isEditingLocation,
                  onTap: () =>
                      setState(() => _isEditingLocation = !_isEditingLocation),
                  editingWidgets: [
                    TextField(
                      onChanged: (value) => _location = value,
                      decoration:
                          const InputDecoration(hintText: 'Enter Location'),
                    ),
                  ],
                  displayWidgets: [
                    _buildDetailRow('Location', _location),
                  ],
                ),

                const SizedBox(height: 16),

                Text('Choose your food type',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                _buildFoodCounter('Non-Veg', _nonVegCount,
                    (value) => setState(() => _nonVegCount = value)),
                _buildFoodCounter('Veg', _vegCount,
                    (value) => setState(() => _vegCount = value)),
                _buildFoodCounter('Jain Veg', _jainVegCount,
                    (value) => setState(() => _jainVegCount = value)),

                // Add ons
                const SizedBox(height: 16),
                const Text('Add-ons (optional)',
                    style: TextStyle(fontSize: 16)),
                TextField(
                  onChanged: (value) => _addOns = value,
                  decoration: InputDecoration(
                    hintText: 'Beef Biriyani',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45)),
                  ),
                ),

                const SizedBox(height: 16),
                // Grand Total Section
                const Text('Grand Total',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                _buildDetailRow('Charges for the day',
                    '₹${_chargesForTheDay.toStringAsFixed(2)}'),
                _buildDetailRow('Tax', '₹${_tax.toStringAsFixed(2)}'),
                _buildDetailRow(
                    'Discounts', '₹${_discounts.toStringAsFixed(2)}'),
                _buildDetailRow('Others', '₹${_others.toStringAsFixed(2)}'),
                _buildDetailRow('Total',
                    '₹${(_chargesForTheDay + _tax - _discounts + _others).toStringAsFixed(2)}',
                    isTotal: true),

                const SizedBox(height: 20),

                FullWidthBlueButton(
                    text: 'Continue',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentScreen()));
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumericInput(
      String label, int value, ValueChanged<int> onChanged) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8.0),
          child: Text(
            label,
            style: TextStyles.ubuntu14black55w400,
          ),
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () => onChanged(value > 1 ? value - 1 : 1),
        ),
        Text('$value'),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => onChanged(value + 1),
        ),
      ],
    );
  }

  Widget _buildDetailRowWithIcon(String label, String value, String iconPath) {
    return Row(
      children: [
        SvgPicture.asset(iconPath, height: 20),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8.0),
          child: Text(label, style: TextStyles.ubuntu14black55w400),
        ),
        const Spacer(),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  Widget _buildEditableSection({
    required String title,
    required bool isEditing,
    required VoidCallback onTap,
    required List<Widget> editingWidgets,
    required List<Widget> displayWidgets,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const Spacer(),
            GestureDetector(
              onTap: onTap,
              child: isEditing
                  ? const Icon(Icons.check)
                  : SvgPicture.asset('assets/icons/Edit_icon.svg'),
            ),
          ],
        ),
        if (isEditing) ...editingWidgets else ...displayWidgets,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildFoodCounter(
      String label, int count, ValueChanged<int> onChanged) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyles.ubuntu16black15w500,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8.0),
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => onChanged(count > 0 ? count - 1 : 0),
                ),
                Text('$count'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => onChanged(count + 1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8.0),
          child: Text(label, style: TextStyles.ubuntu14black55w400),
        ),
        const Spacer(),
        Text(
          value,
          style: isTotal
              ? const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff1F8386))
              : const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
