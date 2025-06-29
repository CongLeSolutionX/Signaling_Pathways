//
//MIT License
//
//Copyright © 2025 Cong Le
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.
//
//
//  SignalingPathwaysView.swift
//  Signaling_Pathways
//
//  Created by Cong Le on 6/29/25.
//

import SwiftUI

/// A color-coded model representing a signaling pathway for UI display.
struct PathwayInfo: Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var iconName: String
    var iconColor: Color
}

/// A SwiftUI view that provides a pedagogical overview of the key cellular signaling pathways involved in corticogenesis.
///
/// This view is designed to be educational, breaking down complex biological processes into visually understandable components.
/// It features a detailed diagram for the Reelin-DAB1 pathway and summary cards for other critical signals.
struct SignalingPathwaysView: View {

    // MARK: - Properties
    
    /// An array of data for displaying the supplementary signaling pathways.
    /// This approach keeps the view's body clean and separates data from presentation.
    private let otherPathways: [PathwayInfo] = [
        .init(name: "Sonic Hedgehog (Shh)",
              description: "Essential for patterning the cortex and controlling cell proliferation and differentiation.",
              iconName: "line.3.crossed.swirl.circle.fill",
              iconColor: .blue),
        .init(name: "BMP-7",
              description: "Promotes the survival and proliferation of neural progenitor cells in the ventricular zone.",
              iconName: "drop.fill",
              iconColor: .cyan),
        .init(name: "Cdk5-p35",
              description: "Influences actin and microtubule dynamics essential for neuronal movement, acting in parallel to the Reelin pathway.",
              iconName: "move.3d",
              iconColor: .purple),
        .init(name: "p57 (CDKN1C)",
              description: "A cell cycle inhibitor that encourages progenitor cells to stop dividing and start differentiating.",
              iconName: "stop.circle.fill",
              iconColor: .orange)
    ]

    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    
                    // MARK: - Introduction Section
                    headerSection
                    
                    // MARK: - Reelin-DAB1 Pathway Diagram
                    SectionHeaderView(title: "Reelin-DAB1 Pathway")
                    ReelinPathwayDiagram()
                    
                    // MARK: - Other Pathways Section
                    SectionHeaderView(title: "Other Critical Signals")
                    
                    // Dynamically create a card for each pathway in the `otherPathways` array.
                    ForEach(otherPathways) { pathway in
                        PathwayDetailCard(pathway: pathway)
                    }
                }
                .padding()
            }
            .navigationTitle("Signaling Pathways")
            .background(Color(.systemGroupedBackground))
        }
    }
    
    /// The introductory text for the view.
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Cellular Communication")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("The precise layering of the cortex depends on an intricate network of signals. These molecules guide migrating neurons, telling them precisely where to stop and form connections.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Sub-Views

/// A private helper view to create consistent section titles.
private struct SectionHeaderView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .padding(.bottom, -15) // Reduce space between header and content
    }
}

/// A visual diagram illustrating the step-by-step process of the Reelin-DAB1 signaling cascade.
private struct ReelinPathwayDiagram: View {
    var body: some View {
        VStack(spacing: 20) {
            // Represents the cell secreting the signal
            SignalSourceCellView()
            
            // Visual representation of the signal being transmitted
            SignalTransmissionView()
            
            // Represents the cell receiving the signal and its internal response
            TargetNeuronView()
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(16)
    }
    
    /// View for the Cajal-Retzius cell that secretes Reelin.
    private func SignalSourceCellView() -> some View {
        VStack {
            Text("Cajal-Retzius Cell")
                .font(.headline)
            Text("(in Marginal Zone)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.green.opacity(0.2))
        .cornerRadius(10)
    }
    
    /// View representing the Reelin protein being sent.
    private func SignalTransmissionView() -> some View {
        HStack {
            Image(systemName: "arrow.down.circle.fill")
                .font(.title)
                .foregroundColor(.green)
            Text("Secretes Reelin Protein")
                .font(.footnote)
                .fontWeight(.medium)
        }
    }
    
    /// View for the migrating neuron that receives the signal and stops.
    private func TargetNeuronView() -> some View {
        VStack(spacing: 15) {
            Text("Migrating Neuron")
                .font(.headline)
            Text("(in Cortical Plate)")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 10) {
                Label("Reelin Binds to Receptors", systemImage: "1.circle.fill")
                Label("Intracellular DAB1 is Activated", systemImage: "2.circle.fill")
                Label("Cytoskeleton is Altered", systemImage: "3.circle.fill")
                Label("Neuron Stops Migrating", systemImage: "4.circle.fill")
                    .foregroundColor(.red)
            }
            .font(.subheadline)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.blue.opacity(0.2))
        .cornerRadius(10)
    }
}

/// A reusable card view to display concise information about a specific signaling pathway.
/// - Parameter pathway: The `PathwayInfo` model containing the data to display.
private struct PathwayDetailCard: View {
    let pathway: PathwayInfo
    
    var body: some View {
        HStack(spacing: 15) {
            // MARK: - Icon
            Image(systemName: pathway.iconName)
                .font(.largeTitle)
                .foregroundColor(pathway.iconColor)
                .frame(width: 50) // Fixed width for alignment
            
            // MARK: - Text Content
            VStack(alignment: .leading, spacing: 4) {
                Text(pathway.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(pathway.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(3) // Ensure the text doesn't overflow excessively
            }
            Spacer() // Pushes content to the left
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Preview

struct SignalingPathwaysView_Previews: PreviewProvider {
    static var previews: some View {
        SignalingPathwaysView()
    }
}
