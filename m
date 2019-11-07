Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02F50F383D
	for <lists+linux-raid@lfdr.de>; Thu,  7 Nov 2019 20:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfKGTK5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 7 Nov 2019 14:10:57 -0500
Received: from mail-qv1-f54.google.com ([209.85.219.54]:32977 "EHLO
        mail-qv1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfKGTK4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 7 Nov 2019 14:10:56 -0500
Received: by mail-qv1-f54.google.com with SMTP id x14so1264165qvu.0
        for <linux-raid@vger.kernel.org>; Thu, 07 Nov 2019 11:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C7E81Zhh3eK2+g9EVGTVA7cqZ7RplPe0cOJ6iRWdrS8=;
        b=MuMSZV4dUMZAK1ZyVtU1UvAEupzi6PRsgTaOj/Mxbe9Szv9mfrzBo5AUwqton6lulH
         kj93uLa5cjsgUZx8kjBixYFahQcz6OQo6ghFeVR4PufPtElS05kG6wwI7bKueXaiC9AY
         idBl801g2VI6Ghho3kGhRdBka5yCqNhp/uHJOaZn7BvQrccOTkxUagChTYeIWI5dRSZ9
         k3UarcE9iNacngL/mHlzvEQZaUzvlPOC2++JqLkjPaUvntx3lsIkNvu/WKK3L5NbPMVR
         lwFOuIJ13TVPfcBKEmPuMvnuMaFXbrTIvmDyNe16o7tiKO77soGrnSkSqJoHo3BRZ7AR
         aV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C7E81Zhh3eK2+g9EVGTVA7cqZ7RplPe0cOJ6iRWdrS8=;
        b=qob88knLA0SD0V3umWH/h1bIhnT8B/W+O+Ayu+fF2W8u91Zxafrxh1OHGcldJUUIjS
         AcKMDjeMB0TQS4/76zkjIXeyQkPLtPsGruGx238+aqXFybvLJUbOrKixsmF5KWzXTVh7
         h9rjBXR67TjLGhYKQP1nowGH361ezKQ/zqb/ICV8F2dso9DBEq/KyeONjMr9uGavpyHY
         dgYcjvqJgOMM1DX8iMTAcvUtIsW53kSoKRSlN/qxqUgK5Ez/rg51NGhD4VThSBaOlOtR
         VYczTGOUgPZ7KuJWB55YxPvpJiu2LTrZA4sINkIEfxJARtLmQlTeZD9QBVbGuqNkCq2J
         gWSQ==
X-Gm-Message-State: APjAAAUlKjR7JhzbgYDEtEtha6fhtIMmTXtZ1d4kfEbyyTJtb6Es+lK0
        Lg14pfhhre4S7d4ev3I7mJk=
X-Google-Smtp-Source: APXvYqyaNSigSbuzCk6zc6okhiI0eMEkceLgAAYlQ29im5LaV3apXmZGxKk/UvXaHP2xtsRZ14Asvw==
X-Received: by 2002:a0c:fe8c:: with SMTP id d12mr5217745qvs.146.1573153855083;
        Thu, 07 Nov 2019 11:10:55 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a3:10e0::3ed7? ([2620:10d:c091:500::1:891c])
        by smtp.gmail.com with ESMTPSA id a4sm743780qkk.113.2019.11.07.11.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 11:10:54 -0800 (PST)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: mdadm release cycle
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     NeilBrown <neilb@suse.de>
References: <3313d626-d84a-2c2a-4162-74097b3dc7b5@canonical.com>
Message-ID: <c65f59ce-8aca-42b0-ebec-f5ebd9646f47@gmail.com>
Date:   Thu, 7 Nov 2019 14:10:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <3313d626-d84a-2c2a-4162-74097b3dc7b5@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/7/19 2:09 PM, Guilherme G. Piccoli wrote:
> Hi folks, I'd like to ask how does the release cycle for mdadm work. I
> noticed version 4.1 was released 1 year ago - is there a cadence for
> version bumps?

There's no fixed schedule, if we feel there's enough updates in the code 
that justifies a release, I'll do a release.

Jes

