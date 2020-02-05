import React from 'react';
import { SiderMenu } from "../SiderMenu";

// antd components
import { Layout } from 'antd';

import './App.scss';

export const App = props => {
    const { Header, Footer, Sider, Content } = Layout;
    return (
        <div className="app">
            <Layout>
                <Sider
                    style={{
                        overflow: 'auto',
                        height: '100vh',
                        position: 'fixed',
                        left: 0,
                    }}
                    theme="light"
                >
                    <div className="sider-brand">
                        GradeManager
                    </div>
                    <SiderMenu /></Sider>
                <Layout>
                    <Header>Header</Header>
                    <Content>Content</Content>
                    <Footer>&!copy</Footer>
                </Layout>
            </Layout>
        </div>
    )
}