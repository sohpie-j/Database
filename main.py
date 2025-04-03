from dash import Dash, dcc, html, dash_table
import plotly.express as px
from performance import star_data, snow_data

app = Dash(__name__)

def explain_section(title, plan):
    return html.Details([
        html.Summary(title),
        html.Pre(html.Code(plan), style={
            "whiteSpace": "pre-wrap",  # Ensures word wrapping
            "fontSize": "12px",
            "fontFamily": "monospace",  # Ensures spacing consistency
            "overflowX": "auto",  # Adds horizontal scroll if needed
            "overflowY": "auto",  # Enables vertical scrolling
            "maxHeight": "5cm",  # Limits height to 5 cm
            "border": "1px solid #ccc",  # Optional: Adds border for clarity
            "padding": "5px"
        })
    ], open=False)

app.layout = html.Div([
    html.H1("Oracle Star vs Snowflake Schema Performance", style={"textAlign": "center"}),

    # ---------- Top Products ----------
    html.H2("Top Products"),
    html.Div([
        dcc.Graph(figure=px.pie(
            star_data['Top Products']['data'],
            names='product_name',
            values='total_sales',
            title='Star Schema'
        )),
        explain_section("Execution Plan (Star)", star_data['Top Products']['explain'])
    ], style={'width': '48%', 'display': 'inline-block'}),

    html.Div([
        dcc.Graph(figure=px.pie(
            snow_data['Top Products']['data'],
            names='product_name',
            values='total_sales',
            title='Snowflake Schema'
        )),
        explain_section("Execution Plan (Snowflake)", snow_data['Top Products']['explain'])
    ], style={'width': '48%', 'display': 'inline-block'}),

    # ---------- Region Revenue ----------
    html.H2("Region Revenue Share"),
    html.Div([
        dcc.Graph(figure=px.pie(
            star_data['Region Revenue Share']['data']
            .groupby('region_name')['total_sales'].sum().reset_index(),
            names='region_name',
            values='total_sales',
            title='Star Schema'
        )),
        explain_section("Execution Plan (Star)", star_data['Region Revenue Share']['explain'])
    ], style={'width': '48%', 'display': 'inline-block'}),

    html.Div([
        dcc.Graph(figure=px.pie(
            snow_data['Region Revenue Share']['data']
            .groupby('region_name')['total_sales'].sum().reset_index(),
            names='region_name',
            values='total_sales',
            title='Snowflake Schema'
        )),
        explain_section("Execution Plan (Snowflake)", snow_data['Region Revenue Share']['explain'])
    ], style={'width': '48%', 'display': 'inline-block'}),

    # ---------- Trend ----------
    html.H2("Trend (Year 2023)"),
    html.Div([
        dcc.Graph(figure=px.scatter(
            star_data['Trend (Year 2023)']['data'],
            x='sales_id',
            y='sales_amount',
            title='Star Schema'
        )),
        explain_section("Execution Plan (Star)", star_data['Trend (Year 2023)']['explain'])
    ], style={'width': '48%', 'display': 'inline-block'}),

    html.Div([
        dcc.Graph(figure=px.scatter(
            snow_data['Trend (Year 2023)']['data'],
            x='sales_id',
            y='sales_amount',
            title='Snowflake Schema'
        )),
        explain_section("Execution Plan (Snowflake)", snow_data['Trend (Year 2023)']['explain'])
    ], style={'width': '48%', 'display': 'inline-block'}),

    # ---------- Customer Sales ----------
    html.H2("Customer Sales"),
    html.Div([
        dcc.Graph(figure=px.bar(
            star_data['Customer Sales']['data']
            .sort_values('total_customer_sales', ascending=False),
            x='customer_name',
            y='total_customer_sales',
            title='Star Schema'
        )),
        explain_section("Execution Plan (Star)", star_data['Customer Sales']['explain'])
    ], style={'width': '48%', 'display': 'inline-block', 'overflowX': 'scroll'}),

    html.Div([
        dcc.Graph(figure=px.bar(
            snow_data['Customer Sales']['data']
            .sort_values('total_customer_sales', ascending=False),
            x='customer_name',
            y='total_customer_sales',
            title='Snowflake Schema'
        )),
        explain_section("Execution Plan (Snowflake)", snow_data['Customer Sales']['explain'])
    ], style={'width': '48%', 'display': 'inline-block', 'overflowX': 'scroll'}),

])

if __name__ == '__main__':
    app.run_server(debug=True)
