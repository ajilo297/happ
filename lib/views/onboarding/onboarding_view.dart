import 'package:flutter/material.dart';
import 'package:happ/core/base/base_view.dart';
import 'package:happ/core/services/preferences_service.dart';
import 'package:happ/views/onboarding/onboarding_view_model.dart';
import 'package:provider/provider.dart';

class OnboardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OnboardingViewModel viewModel = OnboardingViewModel(
      preferenceService: Provider.of<PreferenceService>(context),
    );
    return BaseView<OnboardingViewModel>(
      viewModel: viewModel,
      builder: (context, viewModel, _) {
        return _getView(context, viewModel);
      },
    );
  }

  Widget _getView(BuildContext context, OnboardingViewModel viewModel) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                key: viewModel.formKey,
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  validator: viewModel.validateName,
                  onSaved: (name) async {
                    await viewModel.saveName(name);
                    viewModel.navigateToDashboard(context);
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter your name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton.extended(
                  label: Text('Save'),
                  backgroundColor: Theme.of(context).accentColor,
                  onPressed: viewModel.busy ? null : viewModel.save,
                  foregroundColor: Colors.white,
                  icon: viewModel.busy
                      ? CircularProgressIndicator()
                      : Icon(Icons.done),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
