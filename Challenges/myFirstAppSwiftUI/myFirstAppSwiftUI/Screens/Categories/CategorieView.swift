
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
                NavigationLink(destination: FevoriteView(categoriesViewModel: categoriesViewModel), label: {
                    Image(systemName: "star.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.yellow)})
                
                .padding()
                
                NavigationLink(destination: SearchView(categoriesViewModel: categoriesViewModel), label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.green)})
                
                .padding()
                
                NavigationLink(destination: ProductView(categoriesViewModel: categoriesViewModel, selectedCategory: $categorySelected ) ,isActive: $isActive) {}
                List(categoriesViewModel.categories, id: \.self) { category in
                    Button(action: {
                        categorySelected = category
                        isActive = true
                    }) {
                        Text(category.capitalized)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.green.opacity(0.6))
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .listStyle(PlainListStyle())
                .padding()
            }
        }
        .foregroundColor(.white)
        .font(.title)
        .animation(.default)
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
