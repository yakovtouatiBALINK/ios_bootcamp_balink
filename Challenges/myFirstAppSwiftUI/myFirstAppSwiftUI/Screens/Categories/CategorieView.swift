
import SwiftUI

struct CategoriesListView: View {
    @StateObject var categoriesViewModel = CategoriesViewModel()  //  istance of the VM that get the product
    @State var categorySelected: String = ""                      // this var contain the category that selected
    @State var isActive: Bool = false
    
    var body: some View {
        VStack {
            if let error = categoriesViewModel.error {
                Text("Error: \(error.localizedDescription)")
            } else if categoriesViewModel.products.isEmpty {
                ProgressView()
            } else {
                NavigationLink(destination: ProductView(categoriesViewModel: categoriesViewModel, selectedCategory: $categorySelected ) ,isActive: $isActive) {}
                List(categoriesViewModel.categories, id: \.self) { category in
                    Button(action: {
                        print("bjbhil")
                        categorySelected = category
                        isActive = true
                    }) {
                        Text(category.capitalized)
                    }
                }
                
            }
        }
        .onAppear {
            Task {
                await categoriesViewModel.fetchProducts()  // func that get all products
            }
        }
    }
}

//struct ProductListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoriesListView(selectedCategory: "whgciw")
//    }
//}
