
import SwiftUI

struct CategoriesListView: View {
    @StateObject var categoriesViewModel = CategoriesViewModel()
    @State var categorySelected: String = ""
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
                    createCategoryButton(category: category)
                }
                .listStyle(PlainListStyle())
                .padding()
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        favoriteButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        searchButton()
                    }
                }
            }
        }
        .foregroundColor(.white)
        .font(.title)
        .animation(.default)
        .onAppear {
            Task {
                await categoriesViewModel.fetchProducts()
            }
        }
    }
    
    // func that create favorite button
    func favoriteButton() -> some View {
        NavigationLink(destination: FevoriteView(categoriesViewModel: categoriesViewModel)) {
            Image(systemName: "star.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(.yellow)
        }
        .padding()
    }
    
    // func that create search button
    func searchButton() -> some View {
        NavigationLink(destination: SearchView(categoriesViewModel: categoriesViewModel), label: {
            Image(systemName: "magnifyingglass")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(.green)})
        
        .padding()
    }
    
    // func that create all category
    func createCategoryButton(category: String) -> some View {
        return Button(action: {
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
}
